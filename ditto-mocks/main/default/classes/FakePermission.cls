/*
 * Copyright 2024 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * @group Apex Test Utility
 * @description Fake Permission class for injecting Permission Access responses
 */
@IsTest
public class FakePermission extends Permission {
  private Map<String, Boolean> overriddenPermissions;
  /**
   * @description Constructor.
   * @param overriddenPermissions Permission values you would like to return
   */
  public FakePermission(Map<String, Boolean> overriddenPermissions) {
    this.overriddenPermissions = overriddenPermissions;
  }
  public override Boolean check(String permissionApiName) {
    return overriddenPermissions.containsKey(permissionApiName)
      ? overriddenPermissions.get(permissionApiName)
      : false;
  }
}
