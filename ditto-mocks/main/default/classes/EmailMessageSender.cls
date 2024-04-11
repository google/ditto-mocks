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
 * @description Utility to facilitate Messaging methods in a way that supports mocking
 */
@SuppressWarnings('PMD.AvoidBooleanParameter')
public inherited sharing virtual class EmailMessageSender {
  /**
   * @description Reserves email capacity for future sends.
   * @param emailCount The number of emails to reserve capacity for.
   * @exception LimitException If there is insufficient capacity to reserve the requested number of emails.
   */
  public virtual void reserveEmailCapacity(Integer emailCount) {
    Messaging.reserveSingleEmailCapacity(emailCount);
  }

  /**
   * @description Sends one or more single email messages.
   * @param mails A list of Messaging.SingleEmailMessage objects containing the email messages to send.
   * @param allOrNone A Boolean value specifying whether to send all emails or none at all. If true, all emails are sent or none are sent. If false, individual emails may fail to send but those that are successful are not rolled back.
   * @return A list of Messaging.SendEmailResult objects, one for each email message that was attempted to be sent.
   */
  public virtual List<Messaging.SendEmailResult> sendEmail(
    List<Messaging.SingleEmailMessage> mails,
    Boolean allOrNone
  ) {
    return Messaging.sendEmail(mails, allOrNone);
  }

  /**
   * @description Sends one or more email messages that have already been created.
   * @param emailMessageIds A list of IDs of the email messages to send.
   * @param allOrNone A Boolean value specifying whether to send all emails or none at all. If true, all emails are sent or none are sent. If false, individual emails may fail to send but those that are successful are not rolled back.
   * @return A list of Messaging.SendEmailResult objects, one for each email message that was attempted to be sent.
   */
  public virtual List<Messaging.SendEmailResult> sendEmailMessage(
    List<Id> emailMessageIds,
    Boolean allOrNone
  ) {
    return Messaging.sendEmailMessage(emailMessageIds, allOrNone);
  }
}
