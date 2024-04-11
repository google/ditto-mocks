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
 * @description Mockable way of invoking a flow Interview via the `FlowInterview` class
 */
@IsTest
public class FakeInterview extends Interview {
  public Boolean throwTypeException = false;
  private Map<String, Object> results;

  /**
   * @description Constructor.
   * @param results Mocked results.
   */
  public FakeInterview(Map<String, Object> results) {
    this.results = results;
  }

  public override void createInterview(
    String flowApiName,
    Map<String, Object> inputs
  ) {
    if (throwTypeException) {
      throw new System.TypeException('Invalid type: ' + flowApiName);
    }
  }

  @SuppressWarnings('PMD.EmptyStatementBlock')
  public override void start() {
    // do nothing because we have no real flow to start
  }

  public override Object getVariableValue(String variableName) {
    return this.results.get(variableName);
  }
}
