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
 * @description Fake EmailMessageSender class for injecting Messaging.sendEmailx responses
 */
@IsTest
@SuppressWarnings(
  'PMD.ExcessivePublicCount, PMD.ExcessiveParameterList, PMD.AvoidBooleanParameter'
)
public inherited sharing class FakeEmailMessageSender extends EmailMessageSender {
  private static final String CREATED = 'created';
  private static final String ERRORS = 'errors';
  private static final String ID = 'id';
  private static final String MISMATCHED_INPUT_AND_RESPONSE_SIZE = 'The size of the mocked responses must equal the size of the sObject collection.';
  private static final String SUCCESS = 'success';

  public List<List<Messaging.SingleEmailMessage>> emailRecords = new List<List<Messaging.SingleEmailMessage>>();
  public List<List<Id>> emailMessageListIds = new List<List<Id>>();
  public RESERVE_EMAIL_CAPACITY_FAILURE_TYPE failureType = RESERVE_EMAIL_CAPACITY_FAILURE_TYPE.NONE;
  private List<List<Messaging.SendEmailResult>> orderedEmailResults;
  private Integer orderedEmailResultsIndex = 0;

  /**
   * @description Constructor
   * @param orderedEmailResults Mocked responses
   */
  public FakeEmailMessageSender(
    List<List<Messaging.SendEmailResult>> orderedEmailResults
  ) {
    this.orderedEmailResults = orderedEmailResults;
  }

  private static String buildResultJson(
    Id resultId,
    Boolean isSuccess,
    List<Messaging.SendEmailError> resultErrors
  ) {
    return buildResultJson(resultId, isSuccess, resultErrors, null);
  }

  private static String buildResultJson(
    Id resultId,
    Boolean isSuccess,
    List<Messaging.SendEmailError> resultErrors,
    Boolean isCreated
  ) {
    Map<String, Object> xResult = new Map<String, Object>();
    if (resultId != null) {
      xResult.put(ID, resultId);
    }
    if (isSuccess != null) {
      xResult.put(SUCCESS, isSuccess);
    }
    if (resultErrors != null) {
      xResult.put(ERRORS, resultErrors);
    }
    if (isCreated != null) {
      xResult.put(CREATED, isCreated);
    }
    return JSON.serialize(xResult);
  }

  public override void reserveEmailCapacity(Integer emailCount) {
    if (failureType == RESERVE_EMAIL_CAPACITY_FAILURE_TYPE.NONE) {
      super.reserveEmailCapacity(emailCount);
    } else if (
      failureType == RESERVE_EMAIL_CAPACITY_FAILURE_TYPE.HANDLED_EXCEPTION
    ) {
      throw new System.HandledException('Simulated daily limit exception');
    } else if (failureType == RESERVE_EMAIL_CAPACITY_FAILURE_TYPE.NO_ACCESS) {
      System.NoAccessException noAccessException = new System.NoAccessException();
      noAccessException.setMessage(
        'Simulated access error, such as no email deliverability enabled'
      );
      throw noAccessException;
    }
  }

  public override List<Messaging.SendEmailResult> sendEmail(
    List<Messaging.SingleEmailMessage> mails,
    Boolean allOrNone
  ) {
    List<Messaging.SendEmailResult> results = orderedEmailResults[
      orderedEmailResultsIndex++
    ];
    validateSize(mails, results);
    emailRecords.add(mails);
    return results;
  }

  public override List<Messaging.SendEmailResult> sendEmailMessage(
    List<Id> emailMessageIds,
    Boolean allOrNone
  ) {
    List<Messaging.SendEmailResult> results = orderedEmailResults[
      orderedEmailResultsIndex++
    ];
    validateSize(emailMessageIds, results);
    emailMessageListIds.add(emailMessageIds);
    return results;
  }

  private void validateSize(
    List<Messaging.SingleEmailMessage> mails,
    List<Messaging.SendEmailResult> emailResults
  ) {
    if (
      (mails == null || emailResults == null) ||
      mails.size() != emailResults.size()
    ) {
      throw new IllegalArgumentException(MISMATCHED_INPUT_AND_RESPONSE_SIZE);
    }
  }

  private void validateSize(
    List<Id> idList,
    List<Messaging.SendEmailResult> emailResults
  ) {
    if (
      (idList == null || emailResults == null) ||
      idList.size() != emailResults.size()
    ) {
      throw new IllegalArgumentException(MISMATCHED_INPUT_AND_RESPONSE_SIZE);
    }
  }

  public enum RESERVE_EMAIL_CAPACITY_FAILURE_TYPE {
    // some common exception types related to reserving email capacity
    NONE, //no failure error
    HANDLED_EXCEPTION, //like hit daily sendEmail limit
    NO_ACCESS //like email deliverability is disabled
  }

  @SuppressWarnings('PMD.ApexDoc')
  public class EmailResultBuilder {
    private Id resultId;
    private Boolean isSuccess;
    private List<Messaging.SendEmailError> errors;

    public EmailResultBuilder setResultId(Id resultId) {
      this.resultId = resultId;
      return this;
    }
    public EmailResultBuilder setIsSuccess(Boolean isSuccess) {
      this.isSuccess = isSuccess;
      return this;
    }
    public EmailResultBuilder addError(Messaging.SendEmailError error) {
      this.errors = this.errors ?? new List<Messaging.SendEmailError>();
      this.errors.add(error);
      return this;
    }

    public Messaging.SendEmailResult build() {
      return (Messaging.SendEmailResult) JSON.deserialize(
        buildResultJson(this.resultId, this.isSuccess, this.errors),
        Messaging.SendEmailResult.class
      );
    }
  }
}
