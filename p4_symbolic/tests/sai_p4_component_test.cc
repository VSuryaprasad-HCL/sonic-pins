// Copyright 2024 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
#include <memory>

#include "absl/strings/string_view.h"
#include "absl/time/clock.h"
#include "absl/types/optional.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"
#include "gutil/status_matchers.h"
#include "gutil/testing.h"
#include "p4/v1/p4runtime.pb.h"
#include "p4_pdpi/ir.h"
#include "p4_pdpi/ir.pb.h"
#include "p4_pdpi/pd.h"
#include "p4_symbolic/symbolic/symbolic.h"
#include "p4_symbolic/z3_util.h"
#include "sai_p4/instantiations/google/instantiations.h"
#include "sai_p4/instantiations/google/sai_nonstandard_platforms.h"
#include "sai_p4/instantiations/google/sai_pd.pb.h"
#include "thinkit/bazel_test_environment.h"

namespace p4_symbolic {
namespace {

using ::gutil::ParseProtoOrDie;
using ::p4::config::v1::P4Info;
using ::testing::Eq;
using ::testing::Not;

constexpr absl::string_view kTableEntries = R"pb(
  entries {
    acl_pre_ingress_table_entry {
      match {
        src_mac { value: "22:22:22:11:11:11" mask: "ff:ff:ff:ff:ff:ff" }
        dst_ip { value: "10.0.10.0" mask: "255.255.255.255" }
      }
      action { set_vrf { vrf_id: "vrf-80" } }
      priority: 1
    }
  }
  entries {
    ipv4_table_entry {
      match { vrf_id: "vrf-80" }
      action { set_nexthop_id { nexthop_id: "nexthop-1" } }
    }
  }
  entries {
    l3_admit_table_entry {
      match {
        dst_mac { value: "66:55:44:33:22:10" mask: "ff:ff:ff:ff:ff:ff" }
        in_port { value: "0x005" }
      }
      action { admit_to_l3 {} }
      priority: 1
    }
  }
  entries {
    nexthop_table_entry {
      match { nexthop_id: "nexthop-1" }
      action {
        set_ip_nexthop {
          router_interface_id: "router-interface-1"
          neighbor_id: "fe80::cebb:aaff:fe99:8877"
        }
      }
    }
  }
  entries {
    router_interface_table_entry {
      match { router_interface_id: "router-interface-1" }
      action {
        set_port_and_src_mac { port: "0x002" src_mac: "66:55:44:33:22:11" }
      }
    }
  }
  entries {
    neighbor_table_entry {
      match {
        router_interface_id: "router-interface-1"
        neighbor_id: "fe80::cebb:aaff:fe99:8877"
      }
      action { set_dst_mac { dst_mac: "cc:bb:aa:99:88:77" } }
    }
  }
)pb";

class P4SymbolicComponentTest : public testing::Test {
 public:
  thinkit::TestEnvironment& Environment() { return *environment_; }

 private:
  std::unique_ptr<thinkit::TestEnvironment> environment_ =
      absl::make_unique<thinkit::BazelTestEnvironment>(
          /*mask_known_failures=*/true);
};

absl::StatusOr<std::string> GenerateSmtForSaiPiplelineWithSimpleEntries() {
  const auto config = sai::GetNonstandardForwardingPipelineConfig(
      sai::Instantiation::kMiddleblock, sai::NonstandardPlatform::kP4Symbolic);
  ASSIGN_OR_RETURN(const pdpi::IrP4Info ir_p4info,
                   pdpi::CreateIrP4Info(config.p4info()));
  auto pd_entries = ParseProtoOrDie<sai::TableEntries>(kTableEntries);
  ASSIGN_OR_RETURN(std::vector<p4::v1::Entity> pi_entities,
                   pdpi::PdTableEntriesToPiEntities(ir_p4info, pd_entries));

  ASSIGN_OR_RETURN(std::unique_ptr<symbolic::SolverState> solver,
                   symbolic::EvaluateP4Program(config, pi_entities));
  return solver->GetSolverSMT();
}

// Generate SMT constraints for the SAI pipeline from scratch multiple times and
// make sure the results remain the same.
TEST_F(P4SymbolicComponentTest,
       DISABLED_ConstraintGenerationIsDeterministicForSai) {
  constexpr int kNumberOfRuns = 5;
  ASSERT_OK_AND_ASSIGN(const std::string reference_smt_formula,
                       GenerateSmtForSaiPiplelineWithSimpleEntries());
  for (int run = 0; run < kNumberOfRuns; ++run) {
    LOG(INFO) << "Run " << run;
    ASSERT_OK_AND_ASSIGN(const std::string smt_formula,
                         GenerateSmtForSaiPiplelineWithSimpleEntries());
    ASSERT_THAT(smt_formula, Eq(reference_smt_formula));
  }
}

TEST_F(P4SymbolicComponentTest, CanGenerateTestPacketsForSimpleSaiP4Entries) {
  // Some constants.
  auto env = thinkit::BazelTestEnvironment(/*mask_known_failures=*/false);
  const auto config = sai::GetNonstandardForwardingPipelineConfig(
      sai::Instantiation::kMiddleblock, sai::NonstandardPlatform::kP4Symbolic);
  ASSERT_OK_AND_ASSIGN(const pdpi::IrP4Info ir_p4info,
                       pdpi::CreateIrP4Info(config.p4info()));
  EXPECT_OK(env.StoreTestArtifact("ir_p4info.textproto", ir_p4info));
  EXPECT_OK(env.StoreTestArtifact("p4_config.json", config.p4_device_config()));

  // Prepare hard-coded table entries.
  auto pd_entries = ParseProtoOrDie<sai::TableEntries>(kTableEntries);
  EXPECT_OK(env.StoreTestArtifact("pd_entries.textproto", pd_entries));
  ASSERT_OK_AND_ASSIGN(std::vector<p4::v1::Entity> pi_entities,
                       pdpi::PdTableEntriesToPiEntities(ir_p4info, pd_entries));

  std::vector<int> ports = {1, 2, 3, 4, 5};
  LOG(INFO) << "building model (this may take a while) ...";
  absl::Time start_time = absl::Now();
  LOG(INFO) << "-> done in " << (absl::Now() - start_time);

  // TODO: Generate test packets.
  // symbolic::Solve
  // symbolic::DebugSMT
}

}  // namespace
}  // namespace p4_symbolic
