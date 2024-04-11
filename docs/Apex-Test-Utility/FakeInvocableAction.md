# FakeInvocableAction

`ISTEST`

Mockable InvocableAction


**Inheritance**

[InvocableAction](/Apex-Test-Utility/InvocableAction.md)
 &gt; 
FakeInvocableAction


**Group** Apex Test Utility

## Methods
### `public static createCustomAction(String type, String namespace, String name)`

Creates a fake version of a custom invocable action.

#### Parameters

|Param|Description|
|---|---|
|`type`|Type of action.|
|`namespace`|Namespace of the action.|
|`name`|Name of the action.|

#### Returns

|Type|Description|
|---|---|
|FakeInvocableAction|fake action for mocking.|

### `public static createCustomAction(String type, String name)`

Creates a fake version of a custom invocable action.

#### Parameters

|Param|Description|
|---|---|
|`type`|Type of action.|
|`name`|Name of the action.|

#### Returns

|Type|Description|
|---|---|
|FakeInvocableAction|fake action for mocking.|

### `public static createStandardAction(String type)`

Creates a fake version of a standard invocable action.

#### Parameters

|Param|Description|
|---|---|
|`type`|Type of action.|

#### Returns

|Type|Description|
|---|---|
|FakeInvocableAction|fake action for mocking.|

### `public static resultBuilder()`

Creates a builder.

#### Returns

|Type|Description|
|---|---|
|InvocableActionResultBuilder|The builder.|

### `public static errorBuilder()`

Creates a builder.

#### Returns

|Type|Description|
|---|---|
|InvocableActionErrorBuilder|The builder.|

### `public setResults(List<Invocable.Action.Result> results)`

Sets the mocked results to be returned.

#### Parameters

|Param|Description|
|---|---|
|`results`|The mocked results.|

### `public override invoke()`
### `public addInvocation()`

*Inherited*


Adds a new invocation to the invocable action.

#### Returns

|Type|Description|
|---|---|
|InvocableAction|This InvocableAction object for chaining.|

### `public clearInvocations()`

*Inherited*


Clears all invocations from the invocable action.

### `public getName()`

*Inherited*


Gets the name of the invocable action.

#### Returns

|Type|Description|
|---|---|
|String|The name of the invocable action.|

### `public getNamespace()`

*Inherited*


Gets the namespace of the invocable action.

#### Returns

|Type|Description|
|---|---|
|String|The namespace of the invocable action.|

### `public getType()`

*Inherited*


Gets the type of the invocable action.

#### Returns

|Type|Description|
|---|---|
|String|The type of the invocable action.|

### `public isStandard()`

*Inherited*


Determines whether the invocable action is a standard action.

#### Returns

|Type|Description|
|---|---|
|Boolean|True if the action is a standard action, false otherwise.|

### `public setInvocationParameter(String parameterName, Object parameterValue)`

*Inherited*


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

*Inherited*


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
### FakeActionMaker

`SUPPRESSWARNINGS`

Generates a `FakeInvocableAction` for use in unit tests


**Implemented types**

[InvocableAction.ActionFactory](InvocableAction.ActionFactory)


**Group** Factory

#### Constructors
##### `public FakeActionMaker(List&lt;Invocable.Action.Result&gt; actionResults)`
---
#### Methods
##### `public createCustomAction(String type, String namespace, String name)`
##### `public createCustomAction(String type, String name)`
##### `public createStandardAction(String name)`
---

### InvocableActionErrorBuilder

`SUPPRESSWARNINGS`

Builds `Invocable.Action.Error`


**Group** Builder

#### Methods
##### `public setCode(String code)`
##### `public setMessage(String message)`
##### `public build()`
---

### InvocableActionResultBuilder

`SUPPRESSWARNINGS`

Builds `Invocable.Action.Result`


**Group** Builder

#### Methods
##### `public setOutputParameters(Map&lt;String,Object&gt; outputParameters)`
##### `public setSuccess(Boolean success)`

`SUPPRESSWARNINGS`
##### `public setAction(Invocable action)`
##### `public setErrors(List&lt;Invocable.Action.Error&gt; errors)`
##### `public build()`
---

---
