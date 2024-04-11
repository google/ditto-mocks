# TestUtility

`ISTEST`

Enables the creation of populated records in memory for use in tests


**Group** Apex Test Utility

## Methods
### `public static getFakeId(Schema sObjectType)`

Returns a syntactically correct fake record Id.

#### Parameters

|Param|Description|
|---|---|
|`sObjectType`|The sObjectType for which you would like to generate a fake record Id.|

#### Returns

|Type|Description|
|---|---|
|Id|a fake record Id.|

#### Example
```apex
Case myCase = new Case(Id = TestUtility.getFakeId(Schema.Case.SObjectType));
```


### `public static attachListToParent(SObject parent, List<SObject> children, String parentSideRelationshipName)`

Adds children record to a parent record.

#### Parameters

|Param|Description|
|---|---|
|`parent`|The parent record you would like to add child records.|
|`children`|The collection of children records you would like to relate to the parent record.|
|`parentSideRelationshipName`|The name of the relationship from parent to child.|

#### Returns

|Type|Description|
|---|---|
|SObject|an object with children attached in memory.|

#### Example
```apex
Opportunity opp = new Opportunity();
opp = (Opportunity) TestUtility.attachListToParent(
  opp,
  new List<OpportunityLineItem>{
    new OpportunityLineItem(
      Name = 'My Product',
      Quantity = 10
    )
  },
'OpportunityLineItems',
);
```


### `public static setReadOnlyField(SObject record, String fieldName, Object value)`

Sets a read only field.

#### Parameters

|Param|Description|
|---|---|
|`record`|The record which you would like to set a read-only field for.|
|`fieldName`|The API name of the field you would like to set.|
|`value`|The value you would like to set it to.|

#### Returns

|Type|Description|
|---|---|
|SObject|the object with the read only field populated.|

#### Example
```apex
ProcessInstanceWorkitem workItem = new ProcessInstanceWorkitem();
workItem = (ProcessInstanceWorkitem) TestUtility.setReadOnlyField(
  workItem,
  'ElapsedTimeInHours',
  10
);
```


### `public static setReadOnlyFields(SObject record, Map<String,Object> changesToFields)`

Sets read only fields.

#### Parameters

|Param|Description|
|---|---|
|`record`|The record which you would like to set the read-only field for.|
|`changesToFields`|Map of field API name => value for the fields you wish to set.|

#### Returns

|Type|Description|
|---|---|
|SObject|the record with read only fields populated.|

#### Example
```apex
ProcessInstanceWorkitem workItem = new ProcessInstanceWorkitem();
workItem = (ProcessInstanceWorkitem) TestUtility.setReadOnlyField(
  workItem,
  new Map<String, Object>{
    'ElapsedTimeInHours' => 10
  }
);
```


---
