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
#include "p4_symbolic/sai/deparser.h"

#include <memory>
#include <string>
#include <type_traits>
#include <vector>

#include "absl/status/statusor.h"
#include "absl/strings/str_format.h"
#include "glog/logging.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"
#include "gutil/proto_matchers.h"
#include "gutil/status.h"
#include "gutil/status_matchers.h"
#include "p4/v1/p4runtime.pb.h"
#include "p4_pdpi/packetlib/packetlib.h"
#include "p4_pdpi/packetlib/packetlib.pb.h"
#include "p4_pdpi/string_encodings/bit_string.h"
#include "p4_pdpi/string_encodings/hex_string.h"
#include "p4_symbolic/parser.h"
#include "p4_symbolic/sai/fields.h"
#include "p4_symbolic/sai/parser.h"
#include "p4_symbolic/sai/sai.h"
#include "p4_symbolic/symbolic/symbolic.h"
#include "p4_symbolic/z3_util.h"
#include "sai_p4/instantiations/google/instantiations.h"
#include "sai_p4/instantiations/google/sai_nonstandard_platforms.h"
#include "z3++.h"

namespace p4_symbolic {
namespace {

using ::testing::IsEmpty;

class SaiDeparserTest : public testing::TestWithParam<sai::Instantiation> {
 public:
  void SetUp() override {
    testing::TestWithParam<sai::Instantiation>::SetUp();
    const auto config = sai::GetNonstandardForwardingPipelineConfig(
        /*instantiation=*/GetParam(), sai::NonstandardPlatform::kP4Symbolic);
    ASSERT_OK_AND_ASSIGN(
        state_, EvaluateSaiPipeline(config, /*entries=*/{}, /*ports=*/{}));
  }

 protected:
  std::unique_ptr<symbolic::SolverState> state_;
};

TEST_P(SaiDeparserTest, DeparseIngressAndEgressHeadersWithoutConstraints) {
  ASSERT_EQ(state_->solver->check(), z3::check_result::sat);
  auto model = state_->solver->get_model();
  for (auto& packet :
       {state_->context.ingress_headers, state_->context.egress_headers}) {
    EXPECT_OK(SaiDeparser(packet, model).status());
  }
}

TEST_P(SaiDeparserTest, VlanPacketParserIntegrationTest) {
  // Add parse constraints.
  {
    ASSERT_OK_AND_ASSIGN(auto parse_constraints,
                         EvaluateSaiParser(state_->context.ingress_headers));
    for (auto& constraint : parse_constraints) state_->solver->add(constraint);
  }

  // Add VLAN constraint.
  {
    ASSERT_OK_AND_ASSIGN(SaiFields fields,
                         GetSaiFields(state_->context.ingress_headers));
    state_->solver->add(fields.headers.vlan->valid);
  }

  // Solve and deparse.
  ASSERT_EQ(state_->solver->check(), z3::check_result::sat);
  auto model = state_->solver->get_model();
  ASSERT_OK_AND_ASSIGN(std::string raw_packet,
                       SaiDeparser(state_->context.ingress_headers, model));

  // Check we indeed got a VLAN packet.
  packetlib::Packet packet = packetlib::ParsePacket(raw_packet);
  LOG(INFO) << "Z3-generated packet = " << packet.DebugString();
  ASSERT_GE(packet.headers_size(), 2);
  ASSERT_TRUE(packet.headers(0).has_ethernet_header());
  ASSERT_TRUE(packet.headers(1).has_vlan_header());
}

TEST_P(SaiDeparserTest, Ipv4UdpPacketParserIntegrationTest) {
  // Add parse constraints.
  {
    ASSERT_OK_AND_ASSIGN(auto parse_constraints,
                         EvaluateSaiParser(state_->context.ingress_headers));
    for (auto& constraint : parse_constraints) state_->solver->add(constraint);
  }

  // Add IPv4 + UDP (+ no VLAN) constraint.
  {
    ASSERT_OK_AND_ASSIGN(SaiFields fields,
                         GetSaiFields(state_->context.ingress_headers));
    state_->solver->add(fields.headers.ipv4.valid);
    state_->solver->add(fields.headers.udp.valid);

    state_->solver->add(!fields.headers.vlan->valid);
  }

  // Solve and deparse.
  ASSERT_EQ(state_->solver->check(), z3::check_result::sat);
  auto model = state_->solver->get_model();
  ASSERT_OK_AND_ASSIGN(std::string raw_packet,
                       SaiDeparser(state_->context.ingress_headers, model));

  // Check we indeed got an IPv4 UDP packet.
  packetlib::Packet packet = packetlib::ParsePacket(raw_packet);
  LOG(INFO) << "Z3-generated packet = " << packet.DebugString();
  ASSERT_GE(packet.headers_size(), 3);
  ASSERT_TRUE(packet.headers(0).has_ethernet_header());
  ASSERT_TRUE(packet.headers(1).has_ipv4_header());
  ASSERT_TRUE(packet.headers(2).has_udp_header());
  ASSERT_THAT(packet.payload(), IsEmpty());
}

TEST_P(SaiDeparserTest, Ipv6TcpPacketParserIntegrationTest) {
  // Add parse constraints.
  {
    ASSERT_OK_AND_ASSIGN(auto parse_constraints,
                         EvaluateSaiParser(state_->context.ingress_headers));
    for (auto& constraint : parse_constraints) state_->solver->add(constraint);
  }

  // Add IPv6 + TCP (+ no VLAN) constraint.
  {
    ASSERT_OK_AND_ASSIGN(SaiFields fields,
                         GetSaiFields(state_->context.ingress_headers));
    state_->solver->add(!fields.headers.ipv4.valid);
    state_->solver->add(fields.headers.tcp.valid);
    // The only way to have a TCP packet that is not an IPv4 packet is to have
    // an IPv6 packet.
    state_->solver->add(!fields.headers.vlan->valid);
  }

  // Solve and deparse.
  ASSERT_EQ(state_->solver->check(), z3::check_result::sat);
  auto model = state_->solver->get_model();
  ASSERT_OK_AND_ASSIGN(std::string raw_packet,
                       SaiDeparser(state_->context.ingress_headers, model));

  // Check we indeed got an IPv6 TCP packet.
  packetlib::Packet packet = packetlib::ParsePacket(raw_packet);
  LOG(INFO) << "Z3-generated packet = " << packet.DebugString();
  ASSERT_GE(packet.headers_size(), 3);
  ASSERT_TRUE(packet.headers(0).has_ethernet_header());
  ASSERT_TRUE(packet.headers(1).has_ipv6_header());
  ASSERT_TRUE(packet.headers(2).has_tcp_header());
  ASSERT_THAT(packet.payload(), IsEmpty());
}

TEST_P(SaiDeparserTest, ArpPacketParserIntegrationTest) {
  // Add parse constraints.
  {
    ASSERT_OK_AND_ASSIGN(auto parse_constraints,
                         EvaluateSaiParser(state_->context.ingress_headers));
    for (auto& constraint : parse_constraints) state_->solver->add(constraint);
  }

  // Add ARP (+ no VLAN) constraint.
  {
    ASSERT_OK_AND_ASSIGN(SaiFields fields,
                         GetSaiFields(state_->context.ingress_headers));
    state_->solver->add(fields.headers.arp.valid);
    state_->solver->add(!fields.headers.vlan->valid);
  }

  // Solve and deparse.
  ASSERT_EQ(state_->solver->check(), z3::check_result::sat);
  auto model = state_->solver->get_model();
  ASSERT_OK_AND_ASSIGN(std::string raw_packet,
                       SaiDeparser(state_->context.ingress_headers, model));

  // Check we indeed got an ARP packet.
  packetlib::Packet packet = packetlib::ParsePacket(raw_packet);
  LOG(INFO) << "Z3-generated packet = " << packet.DebugString();
  ASSERT_GE(packet.headers_size(), 2);
  ASSERT_TRUE(packet.headers(0).has_ethernet_header());
  ASSERT_TRUE(packet.headers(1).has_arp_header());
  ASSERT_THAT(packet.payload(), IsEmpty());
}

TEST_P(SaiDeparserTest, IcmpPacketParserIntegrationTest) {
  // Add parse constraints.
  {
    ASSERT_OK_AND_ASSIGN(auto parse_constraints,
                         EvaluateSaiParser(state_->context.ingress_headers));
    for (auto& constraint : parse_constraints) state_->solver->add(constraint);
  }

  // Add ICMP (+ no VLAN) constraint.
  {
    ASSERT_OK_AND_ASSIGN(SaiFields fields,
                         GetSaiFields(state_->context.ingress_headers));
    state_->solver->add(fields.headers.icmp.valid);
    state_->solver->add(!fields.headers.vlan->valid);
  }

  // Solve and deparse.
  ASSERT_EQ(state_->solver->check(), z3::check_result::sat);
  auto model = state_->solver->get_model();
  ASSERT_OK_AND_ASSIGN(std::string raw_packet,
                       SaiDeparser(state_->context.ingress_headers, model));

  // Check we indeed got an ARP packet.
  packetlib::Packet packet = packetlib::ParsePacket(raw_packet);
  LOG(INFO) << "Z3-generated packet = " << packet.DebugString();
  ASSERT_GE(packet.headers_size(), 3);
  ASSERT_TRUE(packet.headers(0).has_ethernet_header());
  ASSERT_TRUE(packet.headers(1).has_ipv4_header() ||
              packet.headers(1).has_ipv6_header());
  ASSERT_TRUE(packet.headers(2).has_icmp_header());
  ASSERT_THAT(packet.payload(), IsEmpty());
}

TEST_P(SaiDeparserTest, PacketInHeaderIsNeverParsedIntegrationTest) {
  // Add parse constraints.
  {
    ASSERT_OK_AND_ASSIGN(auto parse_constraints,
                         EvaluateSaiParser(state_->context.ingress_headers));
    for (auto& constraint : parse_constraints) state_->solver->add(constraint);
  }

  // Add packet_in constraint.
  {
    ASSERT_OK_AND_ASSIGN(SaiFields fields,
                         GetSaiFields(state_->context.ingress_headers));
    EXPECT_TRUE(fields.headers.packet_in.has_value());
    state_->solver->add(fields.headers.packet_in->valid);
  }

  // Should be unsatisfiable, because we never parse a packet-in header.
  ASSERT_EQ(state_->solver->check(), z3::check_result::unsat);
}

using SimpleSaiDeparserTest = testing::TestWithParam<sai::Instantiation>;

TEST_P(SimpleSaiDeparserTest, PacketInHeaderDeparsingIsCorrect) {
  // Set up.
  z3::solver solver = z3::solver(Z3Context());
  const auto config = sai::GetNonstandardForwardingPipelineConfig(
      /*instantiation=*/GetParam(), sai::NonstandardPlatform::kP4Symbolic);
  ASSERT_OK_AND_ASSIGN(ir::Dataplane dataplane,
                       ParseToIr(config, /*entries=*/{}));
  ASSERT_OK_AND_ASSIGN(auto headers,
                       symbolic::SymbolicGuardedMap::CreateSymbolicGuardedMap(
                           dataplane.program.headers()));
  ASSERT_OK_AND_ASSIGN(SaiFields fields, GetSaiFields(headers));

  // Add packet_in constraints.
  EXPECT_TRUE(fields.headers.packet_in.has_value());
  solver.add(fields.headers.packet_in->valid);
  constexpr int kIngressPort = 42;
  constexpr int kTargetEgpressPort = 17;
  constexpr int kUnusedPad = 0;
  solver.add(fields.headers.packet_in->ingress_port == kIngressPort);
  solver.add(fields.headers.packet_in->target_egress_port ==
             kTargetEgpressPort);
  solver.add(fields.headers.packet_in->unused_pad == kUnusedPad);
  packetlib::Header expected_header;
  packetlib::SaiP4BMv2PacketInHeader& packet_in_header =
      *expected_header.mutable_sai_p4_bmv2_packet_in_header();
  packet_in_header.set_ingress_port(pdpi::BitsetToHexString<9>(kIngressPort));
  packet_in_header.set_target_egress_port(
      pdpi::BitsetToHexString<9>(kTargetEgpressPort));
  packet_in_header.set_unused_pad(pdpi::BitsetToHexString<6>(kUnusedPad));

  // Solve and deparse.
  ASSERT_EQ(solver.check(), z3::check_result::sat);
  auto model = solver.get_model();
  ASSERT_OK_AND_ASSIGN(std::string raw_packet, SaiDeparser(headers, model));

  // Check we indeed got a packet_in packet with the correct fields.
  packetlib::Packet packet = packetlib::ParsePacket(
      raw_packet,
      /*first_header=*/packetlib::Header::kSaiP4Bmv2PacketInHeader);
  LOG(INFO) << "Z3-generated packet = " << packet.DebugString();
  ASSERT_GT(packet.headers_size(), 0);
  ASSERT_THAT(packet.headers(0), gutil::EqualsProto(expected_header));
}

INSTANTIATE_TEST_SUITE_P(SaiDeparserTest, SaiDeparserTest,
                         testing::ValuesIn(sai::AllSaiInstantiations()));

INSTANTIATE_TEST_SUITE_P(SimpleSaiDeparserTest, SimpleSaiDeparserTest,
                         testing::ValuesIn(sai::AllSaiInstantiations()));

}  // namespace
}  // namespace p4_symbolic
