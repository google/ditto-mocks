# TestRecord

`ISTEST`

Constructs populated sObjects in memory for use within unit tests.
Includes the generation of fake Id, setting read-only fields, and the population
of parent and children relationships.


**Group** Apex Test Utility

## Methods
### `public static builder(Schema sObjectType)`

create and return a new builder

#### Parameters

|Param|Description|
|---|---|
|`sObjectType`|the type of SObject we would like to construct|

#### Returns

|Type|Description|
|---|---|
|TestRecord|builder|

---
## Classes
### Builder

`SUPPRESSWARNINGS`

Builds an SObject.
Attempted to follow go/java-practices/builders#api, so this is a nested class
even though the `TestRecord` is not what's being built.


**Group** Builder

#### Methods
##### `public setField(Schema field, Object value)`

set a field to a value

###### Parameters

|Param|Description|
|---|---|
|`field`|field to set|
|`value`|value to set|

###### Returns

|Type|Description|
|---|---|
|TestRecord|the builder|

##### `public setParentRelationship(Schema field, SObject parent)`

set a parent relationship to a value

###### Parameters

|Param|Description|
|---|---|
|`field`|relationship to set|
|`parent`|value to set|

###### Returns

|Type|Description|
|---|---|
|TestRecord|the builder|

##### `public setParentRelationship(Schema field, TestRecord builder)`

set a parent relationship to a value

###### Parameters

|Param|Description|
|---|---|
|`field`|relationship to set|
|`builder`|value to set|

###### Returns

|Type|Description|
|---|---|
|TestRecord|the builder|

##### `public setChildRelationship(Schema childRelationshipField, List&lt;SObject&gt; children)`

set a child relationship to a value

###### Parameters

|Param|Description|
|---|---|
|`childRelationshipField`|relationship to set|
|`children`|value to set|

###### Returns

|Type|Description|
|---|---|
|TestRecord|the builder|

##### `public enableNullChildToParentRelationship()`

denote that we are allowing

###### Returns

|Type|Description|
|---|---|
|TestRecord|the builder|

##### `public setChildRelationship(Schema childRelationshipField, List&lt;TestRecord.Builder&gt; builders)`

set a child relationship to a value

###### Parameters

|Param|Description|
|---|---|
|`childRelationshipField`|relationship to set|
|`builders`|value to set|

###### Returns

|Type|Description|
|---|---|
|TestRecord|the builder|

##### `public addToChildRelationship(Schema childRelationshipField, SObject child)`

add a child to a relationship

###### Parameters

|Param|Description|
|---|---|
|`childRelationshipField`|relationship to add to|
|`child`|value add|

###### Returns

|Type|Description|
|---|---|
|TestRecord|the builder|

##### `public addToChildRelationship(Schema childRelationshipField, TestRecord builder)`

add a child to a relationship

###### Parameters

|Param|Description|
|---|---|
|`childRelationshipField`|relationship to add to|
|`builder`|value add|

###### Returns

|Type|Description|
|---|---|
|TestRecord|the builder|

##### `public setIdPrefix(String idPrefix)`

sets and Id prefix explicitly. This is to support sObjects like CaseTeamMember where we cannot dynamically calculate the prefix

###### Parameters

|Param|Description|
|---|---|
|`idPrefix`|the prefix to set|

###### Returns

|Type|Description|
|---|---|
|TestRecord|the builder|

##### `public withoutId()`

denote that we should not create an Id on the built record

###### Returns

|Type|Description|
|---|---|
|TestRecord|the builder|

##### `public build()`

instantiates the record. Uses JSON serialization to set read only fields and relationships

###### Returns

|Type|Description|
|---|---|
|SObject|the built sObject|

##### `public buildAsList()`

instantiates the record, but in a list.

###### Returns

|Type|Description|
|---|---|
|List&lt;SObject&gt;|a list containing the built sObject|

---

---
