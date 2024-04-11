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
 * @description Mockable InvocableAction
 */
@IsTest
public class FakeInvocableAction extends InvocableAction {
  private List<Invocable.Action.Result> results;

  @SuppressWarnings('PMD.EmptyStatementBlock')
  private FakeInvocableAction() {
  }

  /**
   * @description Creates a fake version of a custom invocable action.
   * @param type Type of action.
   * @param namespace Namespace of the action.
   * @param name Name of the action.
   * @return fake action for mocking.
   */
  public static FakeInvocableAction createCustomAction(
    String type,
    String namespace,
    String name
  ) {
    FakeInvocableAction fakeAction = new FakeInvocableAction();
    fakeAction.action = Invocable.Action.createCustomAction(
      type,
      namespace,
      name
    );
    return fakeAction;
  }

  /**
   * @description Creates a fake version of a custom invocable action.
   * @param type Type of action.
   * @param name Name of the action.
   * @return fake action for mocking.
   */
  public static FakeInvocableAction createCustomAction(
    String type,
    String name
  ) {
    FakeInvocableAction fakeAction = new FakeInvocableAction();
    fakeAction.action = Invocable.Action.createCustomAction(type, name);
    return fakeAction;
  }

  /**
   * @description Creates a fake version of a standard invocable action.
   * @param type Type of action.
   * @return fake action for mocking.
   */
  public static FakeInvocableAction createStandardAction(String type) {
    FakeInvocableAction fakeAction = new FakeInvocableAction();
    fakeAction.action = Invocable.Action.createStandardAction(type);
    return fakeAction;
  }

  /**
   * @description Creates a builder.
   * @return The builder.
   */
  public static InvocableActionResultBuilder resultBuilder() {
    return new InvocableActionResultBuilder();
  }

  /**
   * @description Creates a builder.
   * @return The builder.
   */
  public static InvocableActionErrorBuilder errorBuilder() {
    return new InvocableActionErrorBuilder();
  }

  /**
   * @description Sets the mocked results to be returned.
   * @param results The mocked results.
   */
  public void setResults(List<Invocable.Action.Result> results) {
    this.results = results;
  }

  public override List<Invocable.Action.Result> invoke() {
    return this.results;
  }

  /**
   * @group Factory
   * @description  Generates a `FakeInvocableAction` for use in unit tests
   */
  @SuppressWarnings('PMD.ApexDoc')
  public class FakeActionMaker implements InvocableAction.ActionFactory {
    private List<Invocable.Action.Result> actionResults;

    public FakeActionMaker(List<Invocable.Action.Result> actionResults) {
      this.actionResults = actionResults;
    }

    public InvocableAction createCustomAction(
      String type,
      String namespace,
      String name
    ) {
      FakeInvocableAction fakeAction = FakeInvocableAction.createCustomAction(
        type,
        namespace,
        name
      );
      fakeAction.setResults(this.actionResults);
      return fakeAction;
    }

    public InvocableAction createCustomAction(String type, String name) {
      FakeInvocableAction fakeAction = FakeInvocableAction.createCustomAction(
        type,
        name
      );
      fakeAction.setResults(this.actionResults);
      return fakeAction;
    }

    public InvocableAction createStandardAction(String name) {
      FakeInvocableAction fakeAction = FakeInvocableAction.createStandardAction(
        name
      );
      fakeAction.setResults(this.actionResults);
      return fakeAction;
    }
  }

  /**
   * @group Builder
   * @description Builds `Invocable.Action.Result`
   */
  @SuppressWarnings('PMD.ApexDoc')
  public class InvocableActionResultBuilder {
    private Map<String, Object> outputParameters = new Map<String, Object>();
    private Boolean success;
    private Invocable.Action action;
    private List<Invocable.Action.Error> errors;

    @SuppressWarnings('PMD.EmptyStatementBlock')
    private InvocableActionResultBuilder() {
    }

    public InvocableActionResultBuilder setOutputParameters(
      Map<String, Object> outputParameters
    ) {
      this.outputParameters = outputParameters;
      return this;
    }
    @SuppressWarnings('PMD.AvoidBooleanParameter')
    public InvocableActionResultBuilder setSuccess(Boolean success) {
      this.success = success;
      return this;
    }

    public InvocableActionResultBuilder setAction(Invocable.Action action) {
      this.action = action;
      return this;
    }

    public InvocableActionResultBuilder setErrors(
      List<Invocable.Action.Error> errors
    ) {
      this.errors = errors;
      return this;
    }

    public Invocable.Action.Result build() {
      Invocable.Action.Result result = (Invocable.Action.Result) JSON.deserialize(
        JSON.serialize(
          new Map<String, Object>{
            'action' => action,
            'errors' => errors,
            'success' => success,
            'outputParameters' => new Map<String, Object>()
          }
        ),
        Invocable.Action.Result.class
      );
      result.getOutputParameters().putAll(this.outputParameters);
      return result;
    }
  }

  /**
   * @group Builder
   * @description Builds `Invocable.Action.Error`
   */
  @SuppressWarnings('PMD.ApexDoc')
  public class InvocableActionErrorBuilder {
    private String code;
    private String message;

    @SuppressWarnings('PMD.EmptyStatementBlock')
    private InvocableActionErrorBuilder() {
    }

    public InvocableActionErrorBuilder setCode(String code) {
      this.code = code;
      return this;
    }

    public InvocableActionErrorBuilder setMessage(String message) {
      this.message = message;
      return this;
    }

    public Invocable.Action.Error build() {
      return (Invocable.Action.Error) JSON.deserialize(
        JSON.serialize(
          new Map<String, Object>{ 'code' => code, 'message' => message }
        ),
        Invocable.Action.Error.class
      );
    }
  }
}
