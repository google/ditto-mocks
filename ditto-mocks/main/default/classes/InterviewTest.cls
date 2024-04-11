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
 * @description Tests for Interview
 */
@IsTest(isParallel=true)
private class InterviewTest {
  private static final String CREATION_ERROR = 'Something went wrong when calling `createInterview`';
  private static final String VARIABLE_NAME = 'foo';
  private static Interview instance = new Interview();

  @IsTest
  private static void shouldBeAbleToConstructAndInvokeFlowInterview() {
    System.TypeException caught;

    try {
      instance.createInterview('Unit_Test_Flow', new Map<String, Object>());
    } catch (System.TypeException ex) {
      caught = ex;
    }

    System.assertEquals(null, caught, CREATION_ERROR);
    System.assertNotEquals(null, instance, CREATION_ERROR);

    instance.start();

    System.assertEquals(
      'bar',
      instance.getVariableValue(VARIABLE_NAME),
      'The flow set the variable value incorrectly'
    );
  }
}
