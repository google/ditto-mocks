# Classes
## Apex Test Utility

### [DML](/Apex-Test-Utility/DML.md)

Utility to facilitate DML in a way that supports mocking



### [EmailMessageSender](/Apex-Test-Utility/EmailMessageSender.md)

Utility to facilitate Messaging methods in a way that supports mocking



### [FakeDML](/Apex-Test-Utility/FakeDML.md)

Fake DML class for injecting Database.xResult responses



### [FakeEmailMessageSender](/Apex-Test-Utility/FakeEmailMessageSender.md)

Fake EmailMessageSender class for injecting Messaging.sendEmailx responses



### [FakeInterview](/Apex-Test-Utility/FakeInterview.md)

Mockable way of invoking a flow Interview via the `FlowInterview` class



### [FakeInvocableAction](/Apex-Test-Utility/FakeInvocableAction.md)

Mockable InvocableAction



### [FakePermission](/Apex-Test-Utility/FakePermission.md)

Fake Permission class for injecting Permission Access responses



### [Interview](/Apex-Test-Utility/Interview.md)

Calls the `Flow.Interview` class in a way which can support mocking.
`Interview` is a thin layer around `Flow.Interview` and can be mocked with
the `FakeInterview` class



### [InvocableAction](/Apex-Test-Utility/InvocableAction.md)

Calls the `Invocable.Action` class in a way which can support mocking.
`InvocableAction` is a thin layer around `Invocable.Action` and can be mocked with
the `FakeInvocableAction` class



### [Permission](/Apex-Test-Utility/Permission.md)

Utility to facilitate Checking User Permission in a way that supports mocking



### [TestRecord](/Apex-Test-Utility/TestRecord.md)

Constructs populated sObjects in memory for use within unit tests.
Includes the generation of fake Id, setting read-only fields, and the population
of parent and children relationships.



### [TestUtility](/Apex-Test-Utility/TestUtility.md)

Enables the creation of populated records in memory for use in tests


