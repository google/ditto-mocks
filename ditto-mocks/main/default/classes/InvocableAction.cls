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
 * @description Calls the `Invocable.Action` class in a way which can support mocking.
 * `InvocableAction` is a thin layer around `Invocable.Action` and can be mocked with
 * the `FakeInvocableAction` class
 */
public virtual class InvocableAction {
  @TestVisible
  protected Invocable.Action action;

  @SuppressWarnings('PMD.EmptyStatementBlock')
  protected InvocableAction() {
  }

  private InvocableAction(Invocable.Action action) {
    this.action = action;
  }

  /**
   * @description Creates a new custom invocable action.
   * @param type The type of the invocable action.
   * @param namespace The namespace of the invocable action.
   * @param name The name of the invocable action.
   * @return A new InvocableAction object representing the created action.
   */
  public static InvocableAction createCustomAction(
    String type,
    String namespace,
    String name
  ) {
    return new InvocableAction(
      Invocable.Action.createCustomAction(type, namespace, name)
    );
  }

  /**
   * @description Creates a new custom invocable action in the default namespace.
   * @param type The type of the invocable action.
   * @param name The name of the invocable action.
   * @return A new InvocableAction object representing the created action.
   */
  public static InvocableAction createCustomAction(String type, String name) {
    return new InvocableAction(Invocable.Action.createCustomAction(type, name));
  }

  /**
   * @description Creates a new standard invocable action.
   * @param type The type of the standard invocable action.
   * @return A new InvocableAction object representing the created action.
   */
  public static InvocableAction createStandardAction(String type) {
    return new InvocableAction(Invocable.Action.createStandardAction(type));
  }

  /**
   * @description Adds a new invocation to the invocable action.
   * @return This InvocableAction object for chaining.
   */
  public virtual InvocableAction addInvocation() {
    action = action.addInvocation();
    return this;
  }

  /**
   * @description Clears all invocations from the invocable action.
   */
  public virtual void clearInvocations() {
    action.clearInvocations();
  }

  /**
   * @description Gets the name of the invocable action.
   * @return The name of the invocable action.
   */
  public virtual String getName() {
    return action.getName();
  }

  /**
   * @description Gets the namespace of the invocable action.
   * @return The namespace of the invocable action.
   */
  public virtual String getNamespace() {
    return action.getNamespace();
  }

  /**
   * @description Gets the type of the invocable action.
   * @return The type of the invocable action.
   */
  public virtual String getType() {
    return action.getType();
  }

  /**
   * @description Invokes the invocable action.
   * @return A list of results from the invocation.
   */
  public virtual List<Invocable.Action.Result> invoke() {
    return action.invoke();
  }

  /**
   * @description Determines whether the invocable action is a standard action.
   * @return True if the action is a standard action, false otherwise.
   */
  public virtual Boolean isStandard() {
    return action.isStandard();
  }

  /**
   * @description Sets a parameter value for an invocation.
   * @param parameterName The name of the parameter to set.
   * @param parameterValue The value to set for the parameter.
   * @return This InvocableAction object for chaining.
   */
  public virtual InvocableAction setInvocationParameter(
    String parameterName,
    Object parameterValue
  ) {
    action = action.setInvocationParameter(parameterName, parameterValue);
    return this;
  }

  /**
   * @description Sets the invocations for the invocable action.
   * @param invocations A list of maps representing the invocations.
   * @return This InvocableAction object for chaining.
   */
  public virtual InvocableAction setInvocations(
    List<Map<String, Object>> invocations
  ) {
    action = action.setInvocations(invocations);
    return this;
  }

  /**
   * @group Factory
   * @description Factory interface for creating `InvocableAction` "products"
   */
  @SuppressWarnings('PMD.ApexDoc')
  public interface ActionFactory {
    InvocableAction createCustomAction(
      String type,
      String namespace,
      String name
    );
    InvocableAction createCustomAction(String type, String name);
    InvocableAction createStandardAction(String name);
  }

  /**
   * @group Factory
   * @description Default implementation of the factory interface.
   */
  @SuppressWarnings('PMD.ApexDoc')
  public class ActionMaker implements InvocableAction.ActionFactory {
    public InvocableAction createCustomAction(
      String type,
      String namespace,
      String name
    ) {
      return InvocableAction.createCustomAction(type, namespace, name);
    }

    public InvocableAction createCustomAction(String type, String name) {
      return InvocableAction.createCustomAction(type, name);
    }

    public InvocableAction createStandardAction(String name) {
      return InvocableAction.createStandardAction(name);
    }
  }
}
