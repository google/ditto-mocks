# DML

`SUPPRESSWARNINGS`

Utility to facilitate DML in a way that supports mocking


**Group** Apex Test Utility

## Methods
### `public doDelete(SObject record, Boolean allOrNone)`

Delete single record

#### Parameters

|Param|Description|
|---|---|
|`record`|SObject record|
|`allOrNone`|Boolean All Or None|

#### Returns

|Type|Description|
|---|---|
|Database|Database.DeleteResult|

### `public doDelete(List<SObject> records, Boolean allOrNone)`

Delete record list

#### Parameters

|Param|Description|
|---|---|
|`records`|SObject record List|
|`allOrNone`|Boolean All Or None|

#### Returns

|Type|Description|
|---|---|
|List<Database.DeleteResult>|List<Database.DeleteResult>|

### `public doInsert(SObject record, Boolean allOrNone)`

Save single record

#### Parameters

|Param|Description|
|---|---|
|`record`|SObject record|
|`allOrNone`|Boolean All Or None|

#### Returns

|Type|Description|
|---|---|
|Database|Database.SaveResult|

### `public doInsert(List<SObject> records, Boolean allOrNone)`

Save record List

#### Parameters

|Param|Description|
|---|---|
|`records`|SObject record List|
|`allOrNone`|Boolean All Or None|

#### Returns

|Type|Description|
|---|---|
|List<Database.SaveResult>|List<Database.SaveResult>|

### `public doInsert(SObject record, Database dmlOptions)`

Save record

#### Parameters

|Param|Description|
|---|---|
|`record`|SObject record|
|`dmlOptions`|dmlOptions|

#### Returns

|Type|Description|
|---|---|
|Database|Database.SaveResult|

### `public doInsert(List<SObject> records, Database dmlOptions)`

Save record List

#### Parameters

|Param|Description|
|---|---|
|`records`|SObject record List|
|`dmlOptions`|dmlOptions|

#### Returns

|Type|Description|
|---|---|
|List<Database.SaveResult>|List<Database.SaveResult>|

### `public doUpdate(SObject record, Boolean allOrNone)`

update record

#### Parameters

|Param|Description|
|---|---|
|`record`|SObject record|
|`allOrNone`|Boolean All Or None|

#### Returns

|Type|Description|
|---|---|
|Database|Database.SaveResult|

### `public doUpdate(List<SObject> records, Boolean allOrNone)`

Update record List

#### Parameters

|Param|Description|
|---|---|
|`records`|SObject record List|
|`allOrNone`|Boolean All Or None|

#### Returns

|Type|Description|
|---|---|
|List<Database.SaveResult>|List<Database.SaveResult>|

### `public doUpdate(SObject record, Database dmlOptions)`

update record

#### Parameters

|Param|Description|
|---|---|
|`record`|SObject record|
|`dmlOptions`|dmlOptions|

#### Returns

|Type|Description|
|---|---|
|Database|Database.SaveResult|

### `public doUpdate(List<SObject> records, Database dmlOptions)`

update record List

#### Parameters

|Param|Description|
|---|---|
|`records`|SObject record List|
|`dmlOptions`|dmlOptions|

#### Returns

|Type|Description|
|---|---|
|List<Database.SaveResult>|List<Database.SaveResult>|

### `public doUpsert(SObject record, Schema field, Boolean allOrNone)`

upsert record

#### Parameters

|Param|Description|
|---|---|
|`record`|SObject record|
|`field`|SObject field|
|`allOrNone`|Boolean All Or None|

#### Returns

|Type|Description|
|---|---|
|Database|Database.UpsertResult|

### `public doUpsert(List<SObject> records, Schema field, Boolean allOrNone)`

upsert record List

#### Parameters

|Param|Description|
|---|---|
|`records`|SObject record List|
|`field`|SObject field|
|`allOrNone`|Boolean All Or None|

#### Returns

|Type|Description|
|---|---|
|List<Database.UpsertResult>|List<Database.UpsertResult>|

### `public doUndelete(SObject record, Boolean allOrNone)`

undelete record

#### Parameters

|Param|Description|
|---|---|
|`record`|SObject record|
|`allOrNone`|Boolean All Or None|

#### Returns

|Type|Description|
|---|---|
|Database|Database.UndeleteResult|

### `public doUndelete(List<SObject> records, Boolean allOrNone)`

undelete record List

#### Parameters

|Param|Description|
|---|---|
|`records`|SObject record List|
|`allOrNone`|Boolean All Or None|

#### Returns

|Type|Description|
|---|---|
|List<Database.UndeleteResult>|List<Database.UndeleteResult>|

### `public doUndelete(Id recordId, Boolean allOrNone)`

undelete record

#### Parameters

|Param|Description|
|---|---|
|`recordId`|SObject record Id|
|`allOrNone`|Boolean All Or None|

#### Returns

|Type|Description|
|---|---|
|Database|Database.UndeleteResult|

### `public doUndelete(List<Id> recordIds, Boolean allOrNone)`

undelete record List

#### Parameters

|Param|Description|
|---|---|
|`recordIds`|SObject record Id List|
|`allOrNone`|Boolean All Or None|

#### Returns

|Type|Description|
|---|---|
|List<Database.UndeleteResult>|List<Database.UndeleteResult>|

### `public doInsertImmediate(List<SObject> records)`

Save record List

#### Parameters

|Param|Description|
|---|---|
|`records`|SObject record List|

#### Returns

|Type|Description|
|---|---|
|List<Database.SaveResult>|List<Database.SaveResult>|

### `public doDeleteImmediate(List<SObject> records)`

delete record List

#### Parameters

|Param|Description|
|---|---|
|`records`|SObject record List|

#### Returns

|Type|Description|
|---|---|
|List<Database.DeleteResult>|List<Database.DeleteResult>|

---
