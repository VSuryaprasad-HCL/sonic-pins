// Copyright (c) 2024, Google Inc.
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

#ifndef PINS_TESTS_INTEGRATION_SYSTEM_CONTROL_DEVICE_REBOOT_TEST_H_
#define PINS_TESTS_INTEGRATION_SYSTEM_CONTROL_DEVICE_REBOOT_TEST_H_

#include "thinkit/generic_testbed_fixture.h"

namespace pins_test {

class ControlDeviceRebootTestFixture : public thinkit::GenericTestbedFixture<> {
 protected:
  ControlDeviceRebootTestFixture() {
    GetParam().testbed_interface->ExpectLinkFlaps();
  }
};

}  // namespace pins_test

#endif  // PINS_TESTS_INTEGRATION_SYSTEM_CONTROL_DEVICE_REBOOT_TEST_H_
