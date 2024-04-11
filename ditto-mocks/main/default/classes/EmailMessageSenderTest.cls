/*
 * Copyright 2024 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * @group Apex Test Utility
 * @description Tests for EmailMessageSender
 */
@IsTest(isParallel=true)
@SuppressWarnings('PMD.CatchSpecificExceptionType')
private class EmailMessageSenderTest {
  private static Messaging.SingleEmailMessage singleMessage;
  private static EmailMessageSender myEmailMessageSender = new EmailMessageSender();
  private static Exception myException;

  static {
    singleMessage = new Messaging.SingleEmailMessage();
    singleMessage.setSaveAsActivity(true);
    singleMessage.setWhatId(TestUtility.getFakeId(Case.sObjectType));
    singleMessage.setTargetObjectId(TestUtility.getFakeId(Contact.sObjectType));
    singleMessage.setSubject('Test Email Subject');
    singleMessage.setPlainTextBody('Test Email Body');
  }

  @IsTest
  private static void sendEmailOnMultipleRecordsShouldThrowExceptionInCaseOfInvalidIds() {
    try {
      myEmailMessageSender.sendEmail(
        new List<Messaging.SingleEmailMessage>{ singleMessage },
        true
      );
    } catch (Exception e) {
      myException = e;
    }

    System.assertNotEquals(
      null,
      myException,
      'We should get an exception with fake Ids'
    );
    System.assertEquals(
      'System.EmailException',
      myException.getTypeName(),
      'We should get an exception type as System.EmailException with fake Ids'
    );
  }

  @IsTest
  private static void sendEmailPartialOnMultipleRecordsShouldNotThrowException() {
    try {
      myEmailMessageSender.sendEmail(
        new List<Messaging.SingleEmailMessage>{ singleMessage },
        false
      );
    } catch (Exception e) {
      myException = e;
    }

    System.assertEquals(
      null,
      myException,
      'We should not get an exception with partial flag'
    );
  }

  @IsTest
  private static void sendEmailOnEmptyListShouldNotThrowException() {
    try {
      myEmailMessageSender.sendEmail(
        new List<Messaging.SingleEmailMessage>{},
        true
      );
    } catch (Exception e) {
      myException = e;
    }

    System.assertEquals(
      null,
      myException,
      'We should not get an exception with empty list'
    );
  }

  @IsTest
  private static void sendEmailOnNullRequestShouldThrowException() {
    try {
      myEmailMessageSender.sendEmail(null, true);
    } catch (Exception e) {
      myException = e;
    }

    System.assertNotEquals(
      null,
      myException,
      'We should get an exception with fake Ids'
    );
    System.assertEquals(
      'System.IllegalArgumentException',
      myException.getTypeName(),
      'We should get an exception type as System.IllegalArgumentException'
    );
  }

  @IsTest
  private static void sendEmailMessageOnMultipleRecordsShouldThrowExceptionInCaseOfInvalidIds() {
    Id emailMessageId = TestUtility.getFakeId(EmailMessage.sObjectType);

    try {
      myEmailMessageSender.sendEmailMessage(
        new List<Id>{ emailMessageId },
        true
      );
    } catch (Exception e) {
      myException = e;
    }

    System.assertNotEquals(
      null,
      myException,
      'We should get an exception with fake Ids'
    );
    System.assertEquals(
      'System.EmailException',
      myException.getTypeName(),
      'We should get an exception type as System.EmailException  with fake Ids'
    );
  }

  @IsTest
  private static void sendEmailMessagePartialOnMultipleRecordsShouldNotThrowException() {
    Id emailMessageId = TestUtility.getFakeId(EmailMessage.sObjectType);

    try {
      myEmailMessageSender.sendEmailMessage(
        new List<Id>{ emailMessageId },
        false
      );
    } catch (Exception e) {
      myException = e;
    }

    System.assertEquals(
      null,
      myException,
      'We should not get an exception with partial flag'
    );
  }

  @IsTest
  private static void sendEmailMessageOnEmptyListShouldNotThrowException() {
    try {
      myEmailMessageSender.sendEmailMessage(new List<Id>{}, true);
    } catch (Exception e) {
      myException = e;
    }

    System.assertEquals(
      null,
      myException,
      'We should not get an exception with empty list'
    );
  }

  @IsTest
  private static void sendEmailMessageOnNullRequestShouldThrowException() {
    try {
      myEmailMessageSender.sendEmailMessage(null, true);
    } catch (Exception e) {
      myException = e;
    }

    System.assertNotEquals(
      null,
      myException,
      'We should get an exception with fake Ids'
    );
    System.assertEquals(
      'System.IllegalArgumentException',
      myException.getTypeName(),
      'We should get an exception type as System.IllegalArgumentException'
    );
  }

  @IsTest
  private static void reserveEmailCapacityShouldNotThrowException() {
    try {
      myEmailMessageSender.reserveEmailCapacity(1);
    } catch (Exception e) {
      myException = e;
    }

    System.assertEquals(null, myException, 'We should not get an exception.');
  }
}
