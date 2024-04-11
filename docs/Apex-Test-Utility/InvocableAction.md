# InvocableAction

Calls the `Invocable.Action` class in a way which can support mocking.
`InvocableAction` is a thin layer around `Invocable.Action` and can be mocked with
the `FakeInvocableAction` class


**Group** Apex Test Utility

## Methods
### `public static createCustomAction(String type, String namespace, String name)`

Creates a new custom invocable action.

#### Parameters

|Param|Description|
|---|---|
|`type`|The type of the invocable action.|
|`namespace`|The namespace of the invocable action.|
|`name`|The name of the invocable action.|

#### Returns

|Type|Description|
|---|---|
|InvocableAction|A new InvocableAction object representing the created action.|

### `public static createCustomAction(String type, String name)`

Creates a new custom invocable action in the default namespace.

#### Parameters

|Param|Description|
|---|---|
|`type`|The type of the invocable action.|
|`name`|The name of the invocable action.|

#### Returns

|Type|Description|
|---|---|
|InvocableAction|A new InvocableAction object representing the created action.|

### `public static createStandardAction(String type)`

Creates a new standard invocable action.

#### Parameters

|Param|Description|
|---|---|
|`type`|The type of the standard invocable action.|

#### Returns

|Type|Description|
|---|---|
|InvocableAction|A new InvocableAction object representing the created action.|

### `public addInvocation()`

Adds a new invocation to the invocable action.

#### Returns

|Type|Description|
|---|---|
|InvocableAction|This InvocableAction object for chaining.|

### `public clearInvocations()`

Clears all invocations from the invocable action.

### `public getName()`

Gets the name of the invocable action.

#### Returns

|Type|Description|
|---|---|
|String|The name of the invocable action.|

### `public getNamespace()`

Gets the namespace of the invocable action.

#### Returns

|Type|Description|
|---|---|
|String|The namespace of the invocable action.|

### `public getType()`

Gets the type of the invocable action.

#### Returns

|Type|Description|
|---|---|
|String|The type of the invocable action.|

### `public invoke()`

Invokes the invocable action.

#### Returns

|Type|Description|
|---|---|
|List<Invocable.Action.Result>|A list of results from the invocation.|

### `public isStandard()`

Determines whether the invocable action is a standard action.

#### Returns

|Type|Description|
|---|---|
|Boolean|True if the action is a standard action, false otherwise.|

### `public setInvocationParameter(String parameterName, Object parameterValue)`

Sets a parameter value for an invocation.

#### Parameters

|Param|Description|
|---|---|
|`parameterName`|The name of the parameter to set.|
|`parameterValue`|The value to set for the parameter.|

#### Returns

|Type|Description|
|---|---|
|InvocableAction|This InvocableAction object for chaining.|

### `public setInvocations(List<Map<String,Object>> invocations)`

Sets the invocations for the invocable action.

#### Parameters

|Param|Description|
|---|---|
|`invocations`|A list of maps representing the invocations.|

#### Returns

|Type|Description|
|---|---|
|InvocableAction|This InvocableAction object for chaining.|

---
## Classes
### ActionMaker

`SUPPRESSWARNINGS`

Default implementation of the factory interface.


**Implemented types**

[InvocableAction.ActionFactory](InvocableAction.ActionFactory)


**Group** Factory

#### Methods
##### `public createCustomAction(String type, String namespace, String name)`
##### `public createCustomAction(String type, String name)`
##### `public createStandardAction(String name)`
---

---
## Interfaces
### ActionFactory

`SUPPRESSWARNINGS`

Factory interface for creating `InvocableAction` "products"


**Group** Factory

#### Methods
##### `public createCustomAction(String type, String namespace, String name)`

`SUPPRESSWARNINGS`
##### `public createCustomAction(String type, String name)`

`SUPPRESSWARNINGS`
##### `public createStandardAction(String name)`

`SUPPRESSWARNINGS`
---

