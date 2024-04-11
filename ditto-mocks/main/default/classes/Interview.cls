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
 * @description Calls the `Flow.Interview` class in a way which can support mocking.
 * `Interview` is a thin layer around `Flow.Interview` and can be mocked with
 * the `FakeInterview` class
 */
public virtual class Interview {
  @TestVisible
  protected Flow.Interview instance;

  /**
   * @description Creates a new flow interview instance.
   * @param flowApiName The API name of the flow to create an interview for.
   * @param inputs A map of input variables to pass to the flow.
   */
  public virtual void createInterview(
    String flowApiName,
    Map<String, Object> inputs
  ) {
    this.instance = Flow.Interview.createInterview(flowApiName, inputs);
  }

  /**
   * @description Starts the flow interview.
   */
  public virtual void start() {
    this.instance.start();
  }

  /**
   * @description Gets the value of a variable from the flow interview.
   * @param variableName The name of the variable to retrieve the value for.
   * @return The value of the variable, or null if the variable is not found.
   */
  public virtual Object getVariableValue(String variableName) {
    return this.instance.getVariableValue(variableName);
  }
}
