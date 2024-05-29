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
 * @description Fake DML class for injecting Database.xResult responses
 */
@IsTest
@SuppressWarnings(
  'PMD.ExcessivePublicCount, PMD.ExcessiveParameterList, PMD.EmptyCatchBlock, PMD.CyclomaticComplexity, PMD.AvoidBooleanParameter'
)
public inherited sharing class FakeDML extends DML {
  private static final String FIELDS = 'fields';
  private static final String ID = 'id';
  private static final String MESSAGE = 'message';
  private static final String MISMATCHED_INPUT_AND_RESPONSE_SIZE = 'The size of the mocked responses must equal the size of the sObject collection.';
  private static final String STATUS_CODE = 'statusCode';

  public List<List<SObject>> deletedRecords = new List<List<SObject>>();
  public List<List<SObject>> insertedRecords = new List<List<SObject>>();
  public List<List<SObject>> undeletedRecords = new List<List<SObject>>();
  public List<List<SObject>> updatedRecords = new List<List<SObject>>();
  public List<List<SObject>> upsertedRecords = new List<List<SObject>>();

  public List<List<Id>> undeletedIds = new List<List<Id>>();

  private List<List<Database.DeleteResult>> orderedDeleteResults;
  private List<List<Database.SaveResult>> orderedSaveResults;
  private List<List<Database.UndeleteResult>> orderedUndeleteResults;
  private List<List<Database.UpsertResult>> orderedUpsertResults;

  private Integer orderedDeleteResultsIndex = 0;
  private Integer orderedSaveResultsIndex = 0;
  private Integer orderedUndeleteResultsIndex = 0;
  private Integer orderedUpsertResultsIndex = 0;

  /**
   * @description orderedDeleteResults constructor
   * @param orderedDeleteResults Results in the order in which they are to be returned
   */
  public FakeDML(List<List<Database.DeleteResult>> orderedDeleteResults) {
    this.orderedDeleteResults = orderedDeleteResults;
  }

  /**
   * @description orderedSaveResults constructor
   * @param orderedSaveResults Results in the order in which they are to be returned
   */
  public FakeDML(List<List<Database.SaveResult>> orderedSaveResults) {
    this.orderedSaveResults = orderedSaveResults;
  }

  /**
   * @description orderedUpsertResults constructor
   * @param orderedUpsertResults Results in the order in which they are to be returned
   */
  public FakeDML(List<List<Database.UpsertResult>> orderedUpsertResults) {
    this.orderedUpsertResults = orderedUpsertResults;
  }

  /**
   * @description orderedUndeleteResults constructor
   * @param orderedUndeleteResults Results in the order in which they are to be returned
   */
  public FakeDML(List<List<Database.UndeleteResult>> orderedUndeleteResults) {
    this.orderedUndeleteResults = orderedUndeleteResults;
  }

  /**
   * @description FakeDML constructor
   * @param orderedDeleteResults Results in the order in which they are to be returned
   * @param orderedSaveResults Results in the order in which they are to be returned
   * @param orderedUpsertResults Results in the order in which they are to be returned
   * @param orderedUndeleteResults Results in the order in which they are to be returned
   */
  public FakeDML(
    List<List<Database.DeleteResult>> orderedDeleteResults,
    List<List<Database.SaveResult>> orderedSaveResults,
    List<List<Database.UpsertResult>> orderedUpsertResults,
    List<List<Database.UndeleteResult>> orderedUndeleteResults
  ) {
    this.orderedDeleteResults = orderedDeleteResults;
    this.orderedSaveResults = orderedSaveResults;
    this.orderedUpsertResults = orderedUpsertResults;
    this.orderedUndeleteResults = orderedUndeleteResults;
  }

  private static String buildResultJson(
    Id resultId,
    Boolean isSuccess,
    List<Database.Error> resultErrors
  ) {
    return buildResultJson(resultId, isSuccess, resultErrors, null);
  }

  private class ResultJson {
    public final Boolean created;
    public final Boolean success;
    public final Id id;
    public final List<Database.Error> errors;

    @SuppressWarnings('PMD.ExcessiveParameterList')
    public ResultJson(
      Id id,
      Boolean success,
      List<Database.Error> errors,
      Boolean created
    ) {
      this.created = created;
      this.errors = errors;
      this.id = id;
      this.success = success;
    }
  }

  private static String buildResultJson(
    Id resultId,
    Boolean isSuccess,
    List<Database.Error> resultErrors,
    Boolean isCreated
  ) {
    Boolean suppressNulls = true;
    return JSON.serialize(
      new ResultJson(resultId, isSuccess, resultErrors, isCreated),
      suppressNulls
    );
  }

  public override Database.DeleteResult doDelete(
    SObject record,
    Boolean allOrNone
  ) {
    List<Database.DeleteResult> results = orderedDeleteResults[
      orderedDeleteResultsIndex++
    ];
    validateSize(record, results);
    deletedRecords.add(new List<SObject>{ record });
    return results[0];
  }

  public override List<Database.DeleteResult> doDelete(
    List<SObject> records,
    Boolean allOrNone
  ) {
    List<Database.DeleteResult> results = orderedDeleteResults[
      orderedDeleteResultsIndex++
    ];
    validateSize(records, results);
    deletedRecords.add(records);
    return results;
  }

  public override Database.SaveResult doInsert(
    SObject record,
    Boolean allOrNone
  ) {
    List<Database.SaveResult> results = orderedSaveResults[
      orderedSaveResultsIndex++
    ];
    validateSize(record, results);
    try {
      record.Id = TestUtility.getFakeId(record.getSObjectType());
    } catch (System.StringException e) {
      // Do nothing if the TestUtility.getFakeId cannot assign a fake id
    }
    results[0] = setInsertResultRecordId(record.Id, results[0]);
    insertedRecords.add(new List<SObject>{ record });
    return results[0];
  }

  public override List<Database.SaveResult> doInsert(
    List<SObject> records,
    Boolean allOrNone
  ) {
    List<Database.SaveResult> results = orderedSaveResults[
      orderedSaveResultsIndex++
    ];
    validateSize(records, results);
    for (Integer i = 0; i < records.size(); i++) {
      try {
        records[i].Id = TestUtility.getFakeId(records[i].getSObjectType());
      } catch (System.StringException e) {
        // Do nothing if the TestUtility.getFakeId cannot assign a fake id
      }
      results[i] = setInsertResultRecordId(records[i].Id, results[0]);
    }
    insertedRecords.add(records);
    return results;
  }

  public override Database.SaveResult doInsert(
    SObject record,
    Database.DMLOptions dmlOptions
  ) {
    List<Database.SaveResult> results = orderedSaveResults[
      orderedSaveResultsIndex++
    ];
    validateSize(record, results);
    try {
      record.Id = TestUtility.getFakeId(record.getSObjectType());
    } catch (System.StringException e) {
      // Do nothing if the TestUtility.getFakeId cannot assign a fake id
    }
    results[0] = setInsertResultRecordId(record.Id, results[0]);
    insertedRecords.add(new List<SObject>{ record });
    return results[0];
  }

  public override List<Database.SaveResult> doInsert(
    List<SObject> records,
    Database.DMLOptions dmlOptions
  ) {
    List<Database.SaveResult> results = orderedSaveResults[
      orderedSaveResultsIndex++
    ];
    validateSize(records, results);
    for (Integer i = 0; i < records.size(); i++) {
      try {
        records[i].Id = TestUtility.getFakeId(records[i].getSObjectType());
      } catch (System.StringException e) {
        // Do nothing if the TestUtility.getFakeId cannot assign a fake id
      }
      results[i] = setInsertResultRecordId(records[i].Id, results[0]);
    }
    insertedRecords.add(records);
    return results;
  }

  public override Database.SaveResult doUpdate(
    SObject record,
    Boolean allOrNone
  ) {
    List<Database.SaveResult> results = orderedSaveResults[
      orderedSaveResultsIndex++
    ];
    validateSize(record, results);
    updatedRecords.add(new List<SObject>{ record });
    return results[0];
  }

  public override List<Database.SaveResult> doUpdate(
    List<SObject> records,
    Boolean allOrNone
  ) {
    List<Database.SaveResult> results = orderedSaveResults[
      orderedSaveResultsIndex++
    ];
    validateSize(records, results);
    updatedRecords.add(records);
    return results;
  }

  public override Database.SaveResult doUpdate(
    SObject record,
    Database.DMLOptions dmlOptions
  ) {
    List<Database.SaveResult> results = orderedSaveResults[
      orderedSaveResultsIndex++
    ];
    validateSize(record, results);
    updatedRecords.add(new List<SObject>{ record });
    return results[0];
  }

  public override List<Database.SaveResult> doUpdate(
    List<SObject> records,
    Database.DMLOptions dmlOptions
  ) {
    List<Database.SaveResult> results = orderedSaveResults[
      orderedSaveResultsIndex++
    ];
    validateSize(records, results);
    updatedRecords.add(records);
    return results;
  }

  public override Database.UpsertResult doUpsert(
    SObject record,
    Schema.SObjectField field,
    Boolean allOrNone
  ) {
    List<Database.UpsertResult> results = orderedUpsertResults[
      orderedUpsertResultsIndex++
    ];
    validateSize(record, results);
    upsertedRecords.add(new List<SObject>{ record });
    return results[0];
  }

  public override List<Database.UpsertResult> doUpsert(
    List<SObject> records,
    Schema.SObjectField field,
    Boolean allOrNone
  ) {
    List<Database.UpsertResult> results = orderedUpsertResults[
      orderedUpsertResultsIndex++
    ];
    validateSize(records, results);
    upsertedRecords.add(records);
    return results;
  }

  public override Database.UndeleteResult doUndelete(
    SObject record,
    Boolean allOrNone
  ) {
    List<Database.UndeleteResult> results = orderedUndeleteResults[
      orderedUndeleteResultsIndex++
    ];
    validateSize(record, results);
    undeletedRecords.add(new List<SObject>{ record });
    return results[0];
  }

  public override List<Database.UndeleteResult> doUndelete(
    List<SObject> records,
    Boolean allOrNone
  ) {
    List<Database.UndeleteResult> results = orderedUndeleteResults[
      orderedUndeleteResultsIndex++
    ];
    validateSize(records, results);
    undeletedRecords.add(records);
    return results;
  }

  public override Database.UndeleteResult doUndelete(
    Id recordId,
    Boolean allOrNone
  ) {
    List<Database.UndeleteResult> results = orderedUndeleteResults[
      orderedUndeleteResultsIndex++
    ];
    validateSize(recordId, results);
    undeletedIds.add(new List<Id>{ recordId });
    return results[0];
  }

  public override List<Database.UndeleteResult> doUndelete(
    List<Id> recordIds,
    Boolean allOrNone
  ) {
    List<Database.UndeleteResult> results = orderedUndeleteResults[
      orderedUndeleteResultsIndex++
    ];
    validateSize(recordIds, results);
    undeletedIds.add(recordIds);
    return results;
  }

  public override List<Database.SaveResult> doInsertImmediate(
    List<SObject> records
  ) {
    List<Database.SaveResult> results = orderedSaveResults[
      orderedSaveResultsIndex++
    ];
    validateSize(records, results);
    for (Integer i = 0; i < records.size(); i++) {
      try {
        records[i].Id = TestUtility.getFakeId(records[i].getSObjectType());
      } catch (System.StringException e) {
        // Do nothing if the TestUtility.getFakeId cannot assign a fake id
      }
      results[i] = setInsertResultRecordId(records[i].Id, results[0]);
    }
    insertedRecords.add(records);
    return results;
  }

  public override List<Database.DeleteResult> doDeleteImmediate(
    List<SObject> records
  ) {
    List<Database.DeleteResult> results = orderedDeleteResults[
      orderedDeleteResultsIndex++
    ];
    validateSize(records, results);
    for (Integer i = 0; i < records.size(); i++) {
      try {
        records[i].Id = TestUtility.getFakeId(records[i].getSObjectType());
      } catch (System.StringException e) {
        // Do nothing if the TestUtility.getFakeId cannot assign a fake id
      }
      deletedRecords.add(records);
    }
    return results;
  }

  private void validateSize(
    List<Object> objectsForDmlOperation,
    List<Object> databaseResults
  ) {
    if (
      (objectsForDmlOperation == null || databaseResults == null) ||
      objectsForDmlOperation.size() != databaseResults.size()
    ) {
      throw new IllegalArgumentException(MISMATCHED_INPUT_AND_RESPONSE_SIZE);
    }
  }

  private void validateSize(
    Object objectForDmlOperation,
    List<Object> databaseResults
  ) {
    if (
      (objectForDmlOperation == null || databaseResults == null) ||
      1 != databaseResults.size()
    ) {
      throw new IllegalArgumentException(MISMATCHED_INPUT_AND_RESPONSE_SIZE);
    }
  }

  private Database.SaveResult setInsertResultRecordId(
    Id recordId,
    Database.SaveResult insertResult
  ) {
    Map<String, Object> saveResult = (Map<String, Object>) JSON.deserializeUntyped(
      JSON.serialize(insertResult)
    );
    saveResult.put(ID, recordId);
    return (Database.SaveResult) JSON.deserialize(
      JSON.serialize(saveResult),
      Database.SaveResult.class
    );
  }

  /**
   * @description ErrorBuilder
   */
  public class ErrorBuilder {
    private String errorMessage;
    private StatusCode errorStatusCode;
    private List<String> errorFields;

    /**
     * @description setErrorMessage
     * @param errorMessage
     * @return ErrorBuilder
     */
    public ErrorBuilder setErrorMessage(String errorMessage) {
      this.errorMessage = errorMessage;
      return this;
    }

    /**
     * @description setErrorStatusCode
     * @param errorStatusCode
     * @return ErrorBuilder
     */
    public ErrorBuilder setErrorStatusCode(StatusCode errorStatusCode) {
      this.errorStatusCode = errorStatusCode;
      return this;
    }

    /**
     * @description addErrorField
     * @param field
     * @return ErrorBuilder
     */
    public ErrorBuilder addErrorField(String field) {
      this.errorFields = this.errorFields ?? new List<String>();
      this.errorFields.add(field);
      return this;
    }

    /**
     * @description build()
     * @return Database.Error
     */
    public Database.Error build() {
      Map<String, Object> error = new Map<String, Object>{
        FIELDS => this.errorFields,
        MESSAGE => this.errorMessage,
        STATUS_CODE => this.errorStatusCode
      };
      return (Database.Error) JSON.deserialize(
        JSON.serialize(error),
        Database.Error.class
      );
    }
  }

  /**
   * @description SaveResultBuilder
   */
  public class SaveResultBuilder {
    private Id resultId;
    private Boolean isSuccess;
    private List<Database.Error> errors;

    /**
     * @description setResultId
     * @param resultId
     * @return SaveResultBuilder
     */
    public SaveResultBuilder setResultId(Id resultId) {
      this.resultId = resultId;
      return this;
    }

    /**
     * @description setIsSuccess
     * @param isSuccess
     * @return SaveResultBuilder
     */
    public SaveResultBuilder setIsSuccess(Boolean isSuccess) {
      this.isSuccess = isSuccess;
      return this;
    }

    /**
     * @description addError
     * @param error
     * @return SaveResultBuilder
     */
    public SaveResultBuilder addError(Database.Error error) {
      this.errors = this.errors ?? new List<Database.Error>();
      this.errors.add(error);
      return this;
    }

    /**
     * @description build
     * @return Database.SaveResult
     */
    public Database.SaveResult build() {
      return (Database.SaveResult) JSON.deserialize(
        buildResultJson(this.resultId, this.isSuccess, this.errors),
        Database.SaveResult.class
      );
    }
  }

  /**
   * @description DeleteResultBuilder
   */
  public class DeleteResultBuilder {
    private Id resultId;
    private Boolean isSuccess;
    private List<Database.Error> errors;

    /**
     * @description setResultId
     * @param resultId
     * @return DeleteResultBuilder
     */
    public DeleteResultBuilder setResultId(Id resultId) {
      this.resultId = resultId;
      return this;
    }

    /**
     * @description setIsSuccess
     * @param isSuccess
     * @return DeleteResultBuilder
     */
    public DeleteResultBuilder setIsSuccess(Boolean isSuccess) {
      this.isSuccess = isSuccess;
      return this;
    }

    /**
     * @description addError
     * @param error
     * @return DeleteResultBuilder
     */
    public DeleteResultBuilder addError(Database.Error error) {
      this.errors = this.errors ?? new List<Database.Error>();
      this.errors.add(error);
      return this;
    }

    /**
     * @description build
     * @return Database.DeleteResult
     */
    public Database.DeleteResult build() {
      return (Database.DeleteResult) JSON.deserialize(
        buildResultJson(this.resultId, this.isSuccess, this.errors),
        Database.DeleteResult.class
      );
    }
  }

  /**
   * @description UndeleteResultBuilder
   */
  public class UndeleteResultBuilder {
    private Id resultId;
    private Boolean isSuccess;
    private List<Database.Error> errors;

    /**
     * @description setResultId
     * @param resultId
     * @return UndeleteResultBuilder
     */
    public UndeleteResultBuilder setResultId(Id resultId) {
      this.resultId = resultId;
      return this;
    }

    /**
     * @description setIsSuccess
     * @param isSuccess
     * @return UndeleteResultBuilder
     */
    public UndeleteResultBuilder setIsSuccess(Boolean isSuccess) {
      this.isSuccess = isSuccess;
      return this;
    }

    /**
     * @description addError
     * @param error
     * @return UndeleteResultBuilder
     */
    public UndeleteResultBuilder addError(Database.Error error) {
      this.errors = this.errors ?? new List<Database.Error>();
      this.errors.add(error);
      return this;
    }

    /**
     * @description build
     * @return Database.UndeleteResult
     */
    public Database.UndeleteResult build() {
      return (Database.UndeleteResult) JSON.deserialize(
        buildResultJson(this.resultId, this.isSuccess, this.errors),
        Database.UndeleteResult.class
      );
    }
  }

  /**
   * @description UpsertResultBuilder
   */
  public class UpsertResultBuilder {
    private Id resultId;
    private Boolean isSuccess;
    private Boolean resultIsCreated;
    private List<Database.Error> errors;

    /**
     * @description setResultId
     * @param resultId
     * @return UpsertResultBuilder
     */
    public UpsertResultBuilder setResultId(Id resultId) {
      this.resultId = resultId;
      return this;
    }

    /**
     * @description setIsSuccess
     * @param isSuccess
     * @return UpsertResultBuilder
     */
    public UpsertResultBuilder setIsSuccess(Boolean isSuccess) {
      this.isSuccess = isSuccess;
      return this;
    }

    /**
     * @description addError
     * @param error
     * @return UpsertResultBuilder
     */
    public UpsertResultBuilder addError(Database.Error error) {
      this.errors = this.errors ?? new List<Database.Error>();
      this.errors.add(error);
      return this;
    }

    /**
     * @description setResultIsCreated
     * @param resultIsCreated
     * @return UpsertResultBuilder
     */
    public UpsertResultBuilder setResultIsCreated(Boolean resultIsCreated) {
      this.resultIsCreated = resultIsCreated;
      return this;
    }

    /**
     * @description build
     * @return Database.UpsertResult
     */
    public Database.UpsertResult build() {
      return (Database.UpsertResult) JSON.deserialize(
        buildResultJson(
          this.resultId,
          this.isSuccess,
          this.errors,
          this.resultIsCreated
        ),
        Database.UpsertResult.class
      );
    }
  }
}
