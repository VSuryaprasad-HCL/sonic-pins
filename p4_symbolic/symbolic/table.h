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

// Contains functions used to symbolically evaluate P4 tables and their entries.
// A table is turned into a sequence of if-conditions (one per entry),
// each condition corresponds to having that entry matched on, and the
// corresponding then body invokes the appropriate symbolic action expression
// with the parameters specified in the entry.

#ifndef P4_SYMBOLIC_SYMBOLIC_TABLE_H_
#define P4_SYMBOLIC_SYMBOLIC_TABLE_H_

#include <vector>

#include "absl/status/statusor.h"
#include "p4_symbolic/ir/ir.h"
#include "p4_symbolic/ir/ir.pb.h"
#include "p4_symbolic/symbolic/symbolic.h"
#include "p4_symbolic/symbolic/values.h"
#include "z3++.h"

namespace p4_symbolic {
namespace symbolic {
namespace table {

// P4-Symbolic models the default action as an entry with index -1.
constexpr int kDefaultActionEntryIndex = -1;

absl::StatusOr<SymbolicTableMatches> EvaluateTable(
    const ir::Dataplane &data_plane, const ir::Table &table,
    const std::vector<ir::TableEntry> &entries, SymbolicPerPacketState *state,
    values::P4RuntimeTranslator *translator, const z3::expr &guard);

}  // namespace table
}  // namespace symbolic
}  // namespace p4_symbolic

#endif // P4_SYMBOLIC_SYMBOLIC_TABLE_H_
