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
 * @description Utility to facilitate DML in a way that supports mocking
 */
@SuppressWarnings('PMD.AvoidBooleanParameter')
public inherited sharing virtual class DML {
  @TestVisible
  private static DML instance = new DML();

  /**
   * @description Delete single record
   * @param record SObject record
   * @param allOrNone Boolean All Or None
   * @return Database.DeleteResult
   */
  public virtual Database.DeleteResult doDelete(
    SObject record,
    Boolean allOrNone
  ) {
    return Database.delete(record, allOrNone);
  }

  /**
   * @description Delete record list
   * @param records SObject record List
   * @param allOrNone Boolean All Or None
   * @return List<Database.DeleteResult>
   */
  public virtual List<Database.DeleteResult> doDelete(
    List<SObject> records,
    Boolean allOrNone
  ) {
    return Database.delete(records, allOrNone);
  }

  /**
   * @description Save single record
   * @param record SObject record
   * @param allOrNone Boolean All Or None
   * @return Database.SaveResult
   */
  public virtual Database.SaveResult doInsert(
    SObject record,
    Boolean allOrNone
  ) {
    return Database.insert(record, allOrNone);
  }

  /**
   * @description Save record List
   * @param records SObject record List
   * @param allOrNone Boolean All Or None
   * @return List<Database.SaveResult>
   */
  public virtual List<Database.SaveResult> doInsert(
    List<SObject> records,
    Boolean allOrNone
  ) {
    return Database.insert(records, allOrNone);
  }

  /**
   * @description Save record
   * @param record SObject record
   * @param dmlOptions dmlOptions
   * @return Database.SaveResult
   */
  public virtual Database.SaveResult doInsert(
    SObject record,
    Database.DMLOptions dmlOptions
  ) {
    return Database.insert(record, dmlOptions);
  }

  /**
   * @description Save record List
   * @param records SObject record List
   * @param dmlOptions dmlOptions
   * @return List<Database.SaveResult>
   */
  public virtual List<Database.SaveResult> doInsert(
    List<SObject> records,
    Database.DMLOptions dmlOptions
  ) {
    return Database.insert(records, dmlOptions);
  }

  /**
   * @description update record
   * @param record SObject record
   * @param allOrNone Boolean All Or None
   * @return Database.SaveResult
   */
  public virtual Database.SaveResult doUpdate(
    SObject record,
    Boolean allOrNone
  ) {
    return Database.update(record, allOrNone);
  }

  /**
   * @description Update record List
   * @param records SObject record List
   * @param allOrNone Boolean All Or None
   * @return List<Database.SaveResult>
   */
  public virtual List<Database.SaveResult> doUpdate(
    List<SObject> records,
    Boolean allOrNone
  ) {
    return Database.update(records, allOrNone);
  }

  /**
   * @description update record
   * @param record SObject record
   * @param dmlOptions dmlOptions
   * @return Database.SaveResult
   */
  public virtual Database.SaveResult doUpdate(
    SObject record,
    Database.DMLOptions dmlOptions
  ) {
    return Database.update(record, dmlOptions);
  }

  /**
   * @description update record List
   * @param records SObject record List
   * @param dmlOptions dmlOptions
   * @return List<Database.SaveResult>
   */
  public virtual List<Database.SaveResult> doUpdate(
    List<SObject> records,
    Database.DMLOptions dmlOptions
  ) {
    return Database.update(records, dmlOptions);
  }

  /**
   * @description upsert record
   * @param record SObject record
   * @param field SObject field
   * @param allOrNone Boolean All Or None
   * @return Database.UpsertResult
   */
  public virtual Database.UpsertResult doUpsert(
    SObject record,
    Schema.SObjectField field,
    Boolean allOrNone
  ) {
    return Database.upsert(record, field, allOrNone);
  }

  /**
   * @description upsert record List
   * @param records SObject record List
   * @param field SObject field
   * @param allOrNone Boolean All Or None
   * @return List<Database.UpsertResult>
   */
  public virtual List<Database.UpsertResult> doUpsert(
    List<SObject> records,
    Schema.SObjectField field,
    Boolean allOrNone
  ) {
    return Database.upsert(records, field, allOrNone);
  }

  /**
   * @description undelete record
   * @param record SObject record
   * @param allOrNone Boolean All Or None
   * @return Database.UndeleteResult
   */
  public virtual Database.UndeleteResult doUndelete(
    SObject record,
    Boolean allOrNone
  ) {
    return Database.undelete(record, allOrNone);
  }

  /**
   * @description undelete record List
   * @param records SObject record List
   * @param allOrNone Boolean All Or None
   * @return List<Database.UndeleteResult>
   */
  public virtual List<Database.UndeleteResult> doUndelete(
    List<SObject> records,
    Boolean allOrNone
  ) {
    return Database.undelete(records, allOrNone);
  }

  /**
   * @description undelete record
   * @param recordId SObject record Id
   * @param allOrNone Boolean All Or None
   * @return Database.UndeleteResult
   */
  public virtual Database.UndeleteResult doUndelete(
    Id recordId,
    Boolean allOrNone
  ) {
    return Database.undelete(recordId, allOrNone);
  }

  /**
   * @description undelete record List
   * @param recordIds SObject record Id List
   * @param allOrNone Boolean All Or None
   * @return List<Database.UndeleteResult>
   */
  public virtual List<Database.UndeleteResult> doUndelete(
    List<Id> recordIds,
    Boolean allOrNone
  ) {
    return Database.undelete(recordIds, allOrNone);
  }

  /**
   * @description Save record List
   * @param records SObject record List
   * @return List<Database.SaveResult>
   */
  public virtual List<Database.SaveResult> doInsertImmediate(
    List<SObject> records
  ) {
    return Database.insertImmediate(records);
  }

  /**
   * @description delete record List
   * @param records SObject record List
   * @return List<Database.DeleteResult>
   */
  public virtual List<Database.DeleteResult> doDeleteImmediate(
    List<SObject> records
  ) {
    return Database.deleteImmediate(records);
  }
}
