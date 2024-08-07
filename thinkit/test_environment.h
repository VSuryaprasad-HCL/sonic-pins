// Copyright (c) 2020, Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#ifndef THINKIT_TEST_ENVIRONMENT_H_
#define THINKIT_TEST_ENVIRONMENT_H_

#include "absl/status/status.h"
#include "absl/strings/string_view.h"

namespace thinkit {

// The TestEnvironment interface represents the underlying test infrastructure
// to which a test might want to pass additional debug information to.
class TestEnvironment {
 public:
  virtual ~TestEnvironment() {}

  // Stores a test artifact with the specified filename and contents. Overwrites
  // existing files.
  virtual absl::Status StoreTestArtifact(absl::string_view filename,
                                         absl::string_view contents) = 0;

  // Appends contents to an existing test artifact with the specified filename.
  // Creates a new file if it doesn't exist.
  virtual absl::Status AppendToTestArtifact(absl::string_view filename,
                                            absl::string_view contents) = 0;
};

}  // namespace thinkit

#endif  // THINKIT_TEST_ENVIRONMENT_H_
