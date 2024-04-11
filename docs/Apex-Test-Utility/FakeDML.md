# FakeDML

`ISTEST`

`SUPPRESSWARNINGS`

Fake DML class for injecting Database.xResult responses


**Inheritance**

[DML](/Apex-Test-Utility/DML.md)
 &gt; 
FakeDML


**Group** Apex Test Utility

## Constructors
### `public FakeDML(List<List<Database.DeleteResult>> orderedDeleteResults)`

orderedDeleteResults constructor

#### Parameters

|Param|Description|
|---|---|
|`orderedDeleteResults`|Results in the order in which they are to be returned|

### `public FakeDML(List<List<Database.SaveResult>> orderedSaveResults)`

orderedSaveResults constructor

#### Parameters

|Param|Description|
|---|---|
|`orderedSaveResults`|Results in the order in which they are to be returned|

### `public FakeDML(List<List<Database.UpsertResult>> orderedUpsertResults)`

orderedUpsertResults constructor

#### Parameters

|Param|Description|
|---|---|
|`orderedUpsertResults`|Results in the order in which they are to be returned|

### `public FakeDML(List<List<Database.UndeleteResult>> orderedUndeleteResults)`

orderedUndeleteResults constructor

#### Parameters

|Param|Description|
|---|---|
|`orderedUndeleteResults`|Results in the order in which they are to be returned|

### `public FakeDML(List<List<Database.DeleteResult>> orderedDeleteResults, List<List<Database.SaveResult>> orderedSaveResults, List<List<Database.UpsertResult>> orderedUpsertResults, List<List<Database.UndeleteResult>> orderedUndeleteResults)`

FakeDML constructor

#### Parameters

|Param|Description|
|---|---|
|`orderedDeleteResults`|Results in the order in which they are to be returned|
|`orderedSaveResults`|Results in the order in which they are to be returned|
|`orderedUpsertResults`|Results in the order in which they are to be returned|
|`orderedUndeleteResults`|Results in the order in which they are to be returned|

---
## Fields

### `public deletedRecords` → `List<List<SObject>>`


### `public insertedRecords` → `List<List<SObject>>`


### `public undeletedIds` → `List<List<Id>>`


### `public undeletedRecords` → `List<List<SObject>>`


### `public updatedRecords` → `List<List<SObject>>`


### `public upsertedRecords` → `List<List<SObject>>`


---
## Methods
### `public override doDelete(SObject record, Boolean allOrNone)`
### `public override doDelete(List<SObject> records, Boolean allOrNone)`
### `public override doInsert(SObject record, Boolean allOrNone)`
### `public override doInsert(List<SObject> records, Boolean allOrNone)`
### `public override doInsert(SObject record, Database dmlOptions)`
### `public override doInsert(List<SObject> records, Database dmlOptions)`
### `public override doUpdate(SObject record, Boolean allOrNone)`
### `public override doUpdate(List<SObject> records, Boolean allOrNone)`
### `public override doUpdate(SObject record, Database dmlOptions)`
### `public override doUpdate(List<SObject> records, Database dmlOptions)`
### `public override doUpsert(SObject record, Schema field, Boolean allOrNone)`
### `public override doUpsert(List<SObject> records, Schema field, Boolean allOrNone)`
### `public override doUndelete(SObject record, Boolean allOrNone)`
### `public override doUndelete(List<SObject> records, Boolean allOrNone)`
### `public override doUndelete(Id recordId, Boolean allOrNone)`
### `public override doUndelete(List<Id> recordIds, Boolean allOrNone)`
### `public override doInsertImmediate(List<SObject> records)`
### `public override doDeleteImmediate(List<SObject> records)`
---
## Classes
### DeleteResultBuilder

DeleteResultBuilder

#### Methods
##### `public setResultId(Id resultId)`

setResultId

###### Parameters

|Param|Description|
|---|---|
|`resultId`||

###### Returns

|Type|Description|
|---|---|
|DeleteResultBuilder|DeleteResultBuilder|

##### `public setIsSuccess(Boolean isSuccess)`

setIsSuccess

###### Parameters

|Param|Description|
|---|---|
|`isSuccess`||

###### Returns

|Type|Description|
|---|---|
|DeleteResultBuilder|DeleteResultBuilder|

##### `public addError(Database error)`

addError

###### Parameters

|Param|Description|
|---|---|
|`error`||

###### Returns

|Type|Description|
|---|---|
|DeleteResultBuilder|DeleteResultBuilder|

##### `public build()`

build

###### Returns

|Type|Description|
|---|---|
|Database|Database.DeleteResult|

---

### ErrorBuilder

ErrorBuilder

#### Methods
##### `public setErrorMessage(String errorMessage)`

setErrorMessage

###### Parameters

|Param|Description|
|---|---|
|`errorMessage`||

###### Returns

|Type|Description|
|---|---|
|ErrorBuilder|ErrorBuilder|

##### `public setErrorStatusCode(StatusCode errorStatusCode)`

setErrorStatusCode

###### Parameters

|Param|Description|
|---|---|
|`errorStatusCode`||

###### Returns

|Type|Description|
|---|---|
|ErrorBuilder|ErrorBuilder|

##### `public addErrorField(String field)`

addErrorField

###### Parameters

|Param|Description|
|---|---|
|`field`||

###### Returns

|Type|Description|
|---|---|
|ErrorBuilder|ErrorBuilder|

##### `public build()`

build()

###### Returns

|Type|Description|
|---|---|
|Database|Database.Error|

---

### SaveResultBuilder

SaveResultBuilder

#### Methods
##### `public setResultId(Id resultId)`

setResultId

###### Parameters

|Param|Description|
|---|---|
|`resultId`||

###### Returns

|Type|Description|
|---|---|
|SaveResultBuilder|SaveResultBuilder|

##### `public setIsSuccess(Boolean isSuccess)`

setIsSuccess

###### Parameters

|Param|Description|
|---|---|
|`isSuccess`||

###### Returns

|Type|Description|
|---|---|
|SaveResultBuilder|SaveResultBuilder|

##### `public addError(Database error)`

addError

###### Parameters

|Param|Description|
|---|---|
|`error`||

###### Returns

|Type|Description|
|---|---|
|SaveResultBuilder|SaveResultBuilder|

##### `public build()`

build

###### Returns

|Type|Description|
|---|---|
|Database|Database.SaveResult|

---

### UndeleteResultBuilder

UndeleteResultBuilder

#### Methods
##### `public setResultId(Id resultId)`

setResultId

###### Parameters

|Param|Description|
|---|---|
|`resultId`||

###### Returns

|Type|Description|
|---|---|
|UndeleteResultBuilder|UndeleteResultBuilder|

##### `public setIsSuccess(Boolean isSuccess)`

setIsSuccess

###### Parameters

|Param|Description|
|---|---|
|`isSuccess`||

###### Returns

|Type|Description|
|---|---|
|UndeleteResultBuilder|UndeleteResultBuilder|

##### `public addError(Database error)`

addError

###### Parameters

|Param|Description|
|---|---|
|`error`||

###### Returns

|Type|Description|
|---|---|
|UndeleteResultBuilder|UndeleteResultBuilder|

##### `public build()`

build

###### Returns

|Type|Description|
|---|---|
|Database|Database.UndeleteResult|

---

### UpsertResultBuilder

UpsertResultBuilder

#### Methods
##### `public setResultId(Id resultId)`

setResultId

###### Parameters

|Param|Description|
|---|---|
|`resultId`||

###### Returns

|Type|Description|
|---|---|
|UpsertResultBuilder|UpsertResultBuilder|

##### `public setIsSuccess(Boolean isSuccess)`

setIsSuccess

###### Parameters

|Param|Description|
|---|---|
|`isSuccess`||

###### Returns

|Type|Description|
|---|---|
|UpsertResultBuilder|UpsertResultBuilder|

##### `public addError(Database error)`

addError

###### Parameters

|Param|Description|
|---|---|
|`error`||

###### Returns

|Type|Description|
|---|---|
|UpsertResultBuilder|UpsertResultBuilder|

##### `public setResultIsCreated(Boolean resultIsCreated)`

setResultIsCreated

###### Parameters

|Param|Description|
|---|---|
|`resultIsCreated`||

###### Returns

|Type|Description|
|---|---|
|UpsertResultBuilder|UpsertResultBuilder|

##### `public build()`

build

###### Returns

|Type|Description|
|---|---|
|Database|Database.UpsertResult|

---

---
