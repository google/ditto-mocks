# Ditto

Ditto is a mocking library for the Salesforce platform that helps developers to test
their code in an environment isolated from the standard libraries of the Salesforce platform.

## Benefits of Using Ditto

- **Test in isolation**: Ditto allows you to test your code without relying on the Salesforce platform's standard libraries, which can help to identify and fix bugs more quickly.
- **Improve test coverage**: Ditto can help you to increase your test coverage by allowing you to mock out specific parts of the Salesforce platform, such as database operations or email distribution.
- **Speed up testing**: Ditto can help to speed up your testing process by eliminating the need to wait for the Salesforce platform to perform certain operations.

## What Can Ditto Do?

Ditto can help developers to mock some of the core parts of the Salesforce platform including:

- Database Operations
- Email Distribution
- Invocable Action Execution
- Flow Interview Invocation
- Test Record Creation

### Getting Started

For detailed information on how to get started with Ditto and learn how to use its features, please refer to the [project documentation](docs/README.md)

## Examples

### Database Operations

```java
public class MyController {
  public static final String CONTACT_ERROR_MESSAGE = 'Failed to update a contact';
  public static final String ACCOUNT_ERROR_MESSAGE = 'Failed to update an account';

  private final DML dml;

  public MyController() {
    this.dml = new DML();
  }

  @TestVisible
  private MyController(DML dml) {
    this.dml = dml;
  }

  public void updateContactsAndAccounts(
    List<Contact> contacts,
    List<Account> accounts
  ) {
    List<Database.SaveResult> contactResults = this.dml.doUpdate(
      contacts,
      false
    );
    List<Database.SaveResult> accountResults = this.dml.doUpdate(
      accounts,
      false
    );

    for (Database.SaveResult result : contactResults) {
      if (!result.isSuccess()) {
        throw new SObjectException(CONTACT_ERROR_MESSAGE);
      }
    }
    for (Database.SaveResult result : accountResults) {
      if (!result.isSuccess()) {
        throw new SObjectException(ACCOUNT_ERROR_MESSAGE);
      }
    }
  }
}
```

```java
@IsTest
private class MyControllerTest {
  private static List<Contact> contacts = new List<Contact>{
    new Contact(FirstName = 'John', LastName = 'Doe')
  };
  private static List<Account> accounts = new List<Account>{
    new Account(Name = 'Acme')
  };
  private static List<List<Database.SaveResult>> saveResults = new List<List<Database.SaveResult>>();

  private static Database.SaveResult failureResult = new FakeDML.SaveResultBuilder()
    .setIsSuccess(false)
    .addError(
      new FakeDML.ErrorBuilder()
        .setErrorStatusCode(StatusCode.FIELD_CUSTOM_VALIDATION_EXCEPTION)
        .setErrorMessage('This is a test failure!')
        .build()
    )
    .build();

  private static Database.SaveResult successResult = new FakeDML.SaveResultBuilder()
    .setIsSuccess(true)
    .build();

  @IsTest
  private static void unsuccessfulAccountSaveShouldThrowException() {
    // Mock sequential Database Operations
    // Contact save is successful
    saveResults.add(new List<Database.SaveResult>{ successResult });
    // Account save is a failure
    saveResults.add(new List<Database.SaveResult>{ failureResult });

    // Inject mocked Database.SaveResults
    MyController controller = new MyController(new FakeDml(saveResults));

    SObjectException caught;
    try {
      controller.updateContactsAndAccounts(contacts, accounts);
    } catch (SObjectException e) {
      caught = e;
    }

    Assert.isNotNull(caught, 'We should have caught an SObjectException here');
    Assert.areEqual(
      MyController.ACCOUNT_ERROR_MESSAGE,
      caught.getMessage(),
      'The account error message is incorrect'
    );
  }
}
```

### Flow Invocation

```java
public class MyController {
  public static final String FLOW_API_NAME = 'Create_Account_Flow_Api_Name';
  public static final String FLOW_NAME_INPUT_VARIABLE = 'name';
  public static final String FLOW_ACCOUNT_OUTPUT_VARIABLE = 'account';

  private final Interview flowInterview;

  public MyController() {
    this.flowInterview = new Interview();
  }

  @TestVisible
  private MyController(Interview flowInterview) {
    this.flowInterview = flowInterview;
  }

  public Account invokeFlow(String name) {
    flowInterview.createInterview(
      FLOW_API_NAME,
      new Map<String, Object>{ FLOW_NAME_INPUT_VARIABLE => name }
    );
    flowInterview.start();
    return (Account) flowInterview.getVariableValue(
      FLOW_ACCOUNT_OUTPUT_VARIABLE
    );
  }
}
```

```java
@IsTest
private class MyControllerTest {
  private static Account acme = new Account(Name = 'Acme');

  private static FakeInterview fakeFlowInterview = new FakeInterview(
    new Map<String, Object>{ MyController.FLOW_ACCOUNT_OUTPUT_VARIABLE => acme }
  );

  @IsTest
  private static void flowShouldReturnAnAccountWithTheProvidedName() {
    MyController controller = new MyController(fakeFlowInterview);

    Account result = controller.invokeFlow(acme.Name);

    Assert.areEqual(
      acme,
      result,
      'The account is not being properly constructed'
    );
  }
}
```

### Email Distribution

```java
public class MyController {
  public static final String ERROR_MESSAGE = 'Failed to send email';

  private final EmailMessageSender sender;

  public MyController() {
    this.sender = new EmailMessageSender();
  }

  @TestVisible
  private MyController(EmailMessageSender sender) {
    this.sender = sender;
  }

  public void sendMessage(List<Messaging.SingleEmailMessage> toSend) {
    List<Messaging.SendEmailResult> results = sender.sendEmail(toSend, false);

    for (Messaging.SendEmailResult result : results) {
      if (!result.isSuccess()) {
        throw new SObjectException(ERROR_MESSAGE);
      }
    }
  }
}
```

```java
@IsTest
private class MyControllerTest {
  private static List<List<Messaging.SendEmailResult>> results = new List<List<Messaging.SendEmailResult>>();

  private static Messaging.SendEmailResult failureResult = new FakeEmailMessageSender.EmailResultBuilder()
    .setIsSuccess(false)
    .build();

  @IsTest
  private static void unsuccessfulEmailShouldThrowException() {
    Messaging.SingleEmailMessage toSend = new Messaging.SingleEmailMessage();
    toSend.setToAddresses(new List<String>{ 'user1@example.com' });
    toSend.setSubject('An email from Salesforce');
    toSend.setPlainTextBody('This email has been sent through Apex');

    results.add(new List<Messaging.SendEmailResult>{ failureResult });

    MyController controller = new MyController(
      new FakeEmailMessageSender(results)
    );

    SObjectException caught;
    try {
      controller.sendMessage(new List<Messaging.SingleEmailMessage>{ toSend });
    } catch (SObjectException e) {
      caught = e;
    }

    Assert.isNotNull(caught, 'We should have caught an SObjectException here');
    Assert.areEqual(
      myController.ERROR_MESSAGE,
      caught.getMessage(),
      'The account error message is incorrect'
    );
  }
}
```

### Test Record Construction

```java
User currentUser = new User(Id = UserInfo.getUserId());
Account acc = (Account) TestRecord.builder(Account.sObjectType)
  .setField(Account.Name, 'Acme')
  .setParentRelationship(Account.OwnerId, currentUser)
  .setParentRelationship(
    Account.ParentId,
    TestRecord.builder(Account.sObjectType)
      .setField(Account.Name, 'GloboCorp')
  )
  .setChildRelationship(
    Contact.AccountId,
    new List<TestRecord.Builder>{
      TestRecord.builder(Contact.sObjectType)
        .setField(Contact.FirstName, 'John')
        .setField(Contact.LastName, 'Doe')
    }
  )
  .build();
```

## License

See [license](LICENSE) (Apache 2.0).

## Contributing

See [contributing](CONTRIBUTING).
