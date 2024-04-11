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
 * @description Tests for InvocableAction
 */
@IsTest(isParallel=true)
@SuppressWarnings('PMD.CatchSpecificExceptionType')
private class InvocableActionTest {
  private static final String ACTION_NAMESPACE = 'goog';
  private static final String BAR = 'bar';
  private static final String CONSTRUCTION_ERROR = 'Unexpected error occurred when constructing an action.';
  private static final String FLOW_API_NAME = 'Flow_Api_Name';
  private static final String FLOW_STRING = 'Flow';
  private static final String FOO = 'foo';
  private static final String METHOD_ERROR = 'Unexpected error occurred when calling a standard method of `Invocable.Action`.';

  private static InvocableAction action = InvocableAction.createCustomAction(
    FLOW_STRING,
    FLOW_API_NAME
  );
  private static InvocableAction.ActionFactory actionMaker = new InvocableAction.ActionMaker();
  private static System.TypeException caughtTypeError;
  private static Exception caught;

  @IsTest
  private static void shouldBeAbleToConstructCustomActionWithNamespace() {
    try {
      action = InvocableAction.createCustomAction(
        FLOW_STRING,
        ACTION_NAMESPACE,
        FLOW_API_NAME
      );
    } catch (System.TypeException ex) {
      caughtTypeError = ex;
    }

    System.assertEquals(null, caughtTypeError, CONSTRUCTION_ERROR);
  }

  @IsTest
  private static void shouldBeAbleToConstructCustomAction() {
    try {
      action = InvocableAction.createCustomAction(FLOW_STRING, FLOW_API_NAME);
    } catch (System.TypeException ex) {
      caughtTypeError = ex;
    }

    System.assertEquals(null, caughtTypeError, CONSTRUCTION_ERROR);
  }

  @IsTest
  private static void shouldBeAbleToConstructStandardAction() {
    try {
      action = InvocableAction.createStandardAction(FLOW_STRING);
    } catch (System.TypeException ex) {
      caughtTypeError = ex;
    }

    System.assertEquals(null, caughtTypeError, CONSTRUCTION_ERROR);
  }

  @IsTest
  private static void actionMakerShouldBeAbleToConstructCustomActionWithNamespace() {
    try {
      action = actionMaker.createCustomAction(
        FLOW_STRING,
        ACTION_NAMESPACE,
        FLOW_API_NAME
      );
    } catch (System.TypeException ex) {
      caughtTypeError = ex;
    }

    System.assertEquals(null, caughtTypeError, CONSTRUCTION_ERROR);
  }

  @IsTest
  private static void actionMakerShouldBeAbleToConstructCustomAction() {
    try {
      action = actionMaker.createCustomAction(FLOW_STRING, FLOW_API_NAME);
    } catch (System.TypeException ex) {
      caughtTypeError = ex;
    }

    System.assertEquals(null, caughtTypeError, CONSTRUCTION_ERROR);
  }

  @IsTest
  private static void actionMakerShouldBeAbleToConstructStandardAction() {
    try {
      action = actionMaker.createStandardAction(FLOW_STRING);
    } catch (System.TypeException ex) {
      caughtTypeError = ex;
    }

    System.assertEquals(null, caughtTypeError, CONSTRUCTION_ERROR);
  }

  @IsTest
  private static void shouldBeAbleToAddInvocation() {
    try {
      action.addInvocation();
    } catch (Exception ex) {
      caught = ex;
    }

    System.assertEquals(null, caught, METHOD_ERROR);
  }

  @IsTest
  private static void shouldBeAbleToClearInvocations() {
    try {
      action.clearInvocations();
    } catch (Exception ex) {
      caught = ex;
    }

    System.assertEquals(null, caught, METHOD_ERROR);
  }

  @IsTest
  private static void shouldBeAbleToGetName() {
    System.assertEquals(FLOW_API_NAME, action.getName(), METHOD_ERROR);
  }

  @IsTest
  private static void shouldBeAbleToGetNamespace() {
    action = InvocableAction.createCustomAction(
      FLOW_STRING,
      ACTION_NAMESPACE,
      FLOW_API_NAME
    );

    System.assertEquals(ACTION_NAMESPACE, action.getNamespace(), METHOD_ERROR);
  }

  @IsTest
  private static void shouldBeAbleToGetType() {
    System.assertEquals(FLOW_STRING, action.getType(), METHOD_ERROR);
  }

  @IsTest
  private static void shouldBeAbleToInvoke() {
    List<Invocable.Action.Result> results = action.invoke();

    System.assertEquals(
      'Action name not found: Flow_Api_Name',
      results[0].getErrors()[0].getMessage(),
      METHOD_ERROR
    );
  }

  @IsTest
  private static void shouldBeAbleToDetermineIfStandard() {
    System.assertEquals(false, action.isStandard(), METHOD_ERROR);
  }

  @IsTest
  private static void shouldBeAbleToSetInvocationParameter() {
    try {
      action.setInvocationParameter(foo, BAR);
    } catch (Exception ex) {
      caught = ex;
    }

    System.assertEquals(null, caught, METHOD_ERROR);
  }

  @IsTest
  private static void shouldBeAbleToSetInvocation() {
    try {
      action.setInvocations(new List<Map<String, Object>>());
    } catch (Exception ex) {
      caught = ex;
    }

    System.assertEquals(null, caught, METHOD_ERROR);
  }
}
