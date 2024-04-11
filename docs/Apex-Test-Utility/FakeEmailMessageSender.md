# FakeEmailMessageSender

`ISTEST`

`SUPPRESSWARNINGS`

Fake EmailMessageSender class for injecting Messaging.sendEmailx responses


**Inheritance**

[EmailMessageSender](/Apex-Test-Utility/EmailMessageSender.md)
 &gt; 
FakeEmailMessageSender


**Group** Apex Test Utility

## Constructors
### `public FakeEmailMessageSender(List<List<Messaging.SendEmailResult>> orderedEmailResults)`

Constructor

#### Parameters

|Param|Description|
|---|---|
|`orderedEmailResults`|Mocked responses|

---
## Fields

### `public emailMessageListIds` → `List<List<Id>>`


### `public emailRecords` → `List<List<Messaging.SingleEmailMessage>>`


### `public failureType` → `RESERVE_EMAIL_CAPACITY_FAILURE_TYPE`


---
## Methods
### `public override reserveEmailCapacity(Integer emailCount)`
### `public override sendEmail(List<Messaging.SingleEmailMessage> mails, Boolean allOrNone)`
### `public override sendEmailMessage(List<Id> emailMessageIds, Boolean allOrNone)`
---
## Enums
### RESERVE_EMAIL_CAPACITY_FAILURE_TYPE

---
## Classes
### EmailResultBuilder

`SUPPRESSWARNINGS`
#### Methods
##### `public setResultId(Id resultId)`
##### `public setIsSuccess(Boolean isSuccess)`
##### `public addError(Messaging error)`
##### `public build()`
---

---
