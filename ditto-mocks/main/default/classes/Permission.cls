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
 * @description Utility to facilitate Checking User Permission in a way that supports mocking
 */
public inherited sharing virtual class Permission {
  /**
   * @description Checks whether a user has a specific feature permission enabled.
   * @param permissionApiName The API name of the feature permission to check.
   * @return True if the user has the permission enabled, false otherwise.
   */
  public virtual Boolean check(String permissionApiName) {
    return FeatureManagement.checkPermission(permissionApiName);
  }
}
