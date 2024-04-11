# EmailMessageSender

`SUPPRESSWARNINGS`

Utility to facilitate Messaging methods in a way that supports mocking


**Group** Apex Test Utility

## Methods
### `public reserveEmailCapacity(Integer emailCount)`

Reserves email capacity for future sends.

#### Parameters

|Param|Description|
|---|---|
|`emailCount`|The number of emails to reserve capacity for.|

#### Throws

|Exception|Description|
|---|---|
|`LimitException`|If there is insufficient capacity to reserve the requested number of emails.|

### `public sendEmail(List<Messaging.SingleEmailMessage> mails, Boolean allOrNone)`

Sends one or more single email messages.

#### Parameters

|Param|Description|
|---|---|
|`mails`|A list of Messaging.SingleEmailMessage objects containing the email messages to send.|
|`allOrNone`|A Boolean value specifying whether to send all emails or none at all. If true, all emails are sent or none are sent. If false, individual emails may fail to send but those that are successful are not rolled back.|

#### Returns

|Type|Description|
|---|---|
|List<Messaging.SendEmailResult>|A list of Messaging.SendEmailResult objects, one for each email message that was attempted to be sent.|

### `public sendEmailMessage(List<Id> emailMessageIds, Boolean allOrNone)`

Sends one or more email messages that have already been created.

#### Parameters

|Param|Description|
|---|---|
|`emailMessageIds`|A list of IDs of the email messages to send.|
|`allOrNone`|A Boolean value specifying whether to send all emails or none at all. If true, all emails are sent or none are sent. If false, individual emails may fail to send but those that are successful are not rolled back.|

#### Returns

|Type|Description|
|---|---|
|List<Messaging.SendEmailResult>|A list of Messaging.SendEmailResult objects, one for each email message that was attempted to be sent.|

---
