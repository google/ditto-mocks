# Interview

Calls the `Flow.Interview` class in a way which can support mocking.
`Interview` is a thin layer around `Flow.Interview` and can be mocked with
the `FakeInterview` class


**Group** Apex Test Utility

## Methods
### `public createInterview(String flowApiName, Map<String,Object> inputs)`

Creates a new flow interview instance.

#### Parameters

|Param|Description|
|---|---|
|`flowApiName`|The API name of the flow to create an interview for.|
|`inputs`|A map of input variables to pass to the flow.|

### `public start()`

Starts the flow interview.

### `public getVariableValue(String variableName)`

Gets the value of a variable from the flow interview.

#### Parameters

|Param|Description|
|---|---|
|`variableName`|The name of the variable to retrieve the value for.|

#### Returns

|Type|Description|
|---|---|
|Object|The value of the variable, or null if the variable is not found.|

---
