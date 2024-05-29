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
 * @description Constructs populated sObjects in memory for use within unit tests.
 * Includes the generation of fake Id, setting read-only fields, and the population
 * of parent and children relationships.
 *
 * @example Set read-only fields
 * Opportunity opp = (Opportunity) TestRecord.builder(Opportunity.sObjectType)
 *   .setField(Opportunity.IsClosed, true)
 *   .build();
 *
 * @example Populate parent/child relationships with SObjects or other TestRecord.Builders
 * User currentUser = new User(Id = UserInfo.getUserId());
 * Account acc = (Account) TestRecord.builder(Account.sObjectType)
 *   .setField(Account.Name, 'Acme')
 *   .setParentRelationship(Account.OwnerId, currentUser)
 *   .setParentRelationship(
 *     Account.ParentId,
 *     TestRecord.builder(Account.sObjectType)
 *       .setField(Account.Name, 'GloboCorp')
 *   )
 *   .setChildRelationship(
 *     Contact.AccountId,
 *     new List<TestRecord.Builder>{
 *       TestRecord.builder(Contact.sObjectType)
 *         .setField(Contact.FirstName, 'John')
 *         .setField(Contact.LastName, 'Doe')
 *     }
 *   )
 *   .addToChildRelationship(
 *     Contact.AccountId,
 *     TestRecord.builder(Contact.sObjectType)
 *       .setField(Contact.FirstName, 'Jane')
 *       .setField(Contact.LastName, 'Smith')
 *   )
 *   .setChildRelationship(
 *     Opportunity.AccountId,
 *     new List<SObject>{
 *       TestRecord.builder(Opportunity.sObjectType)
 *         .setField(Opportunity.IsClosed, true)
 *         .build()
 *     }
 *   )
 *   .addToChildRelationship(
 *     Opportunity.AccountId,
 *     TestRecord.builder(Opportunity.sObjectType)
 *       .setField(Opportunity.IsClosed, false)
 *       .build()
 *   )
 *   .build();
 *
 * @example Manually specify Id prefix
 * CaseTeamMember teamMember = (CaseTeamMember) TestRecord.builder(CaseTeamMember.sObjectType)
 *   .setIdPrefix('0B6')
 *   .build();
 *
 * @example: Suppress Id generation
 * Case toInsert = (Case) TestRecord.builder(Case.sObjectType)
 *   .setField(Case.Subject, 'Please help')
 *   .withoutId()
 *   .build();
 *
 * @example Build As List
 * List<Case> triggerNew = (List<Case>) TestRecord.builder(Case.sObjectType)
 *   .setField(Case.Subject, 'Please help')
 *   .buildAsList();
 */
@IsTest
public inherited sharing class TestRecord {
  private static Integer lastId = 1;

  @SuppressWarnings('PMD.EmptyStatementBlock')
  private TestRecord() {
  }

  /**
   * @description create and return a new builder
   * @param sObjectType the type of SObject we would like to construct
   * @return builder
   */
  public static TestRecord.Builder builder(Schema.SObjectType sObjectType) {
    return new TestRecord.Builder(sObjectType);
  }

  private static Id generateIdFromPrefix(String objectPrefix) {
    String recordCount = String.valueOf(lastId++);
    return (Id) (objectPrefix +
    '0'.repeat(12 - recordCount.length()) +
    recordCount);
  }

  /**
   * @group Builder
   * @description Builds an SObject.
   * Attempted to follow go/java-practices/builders#api, so this is a nested class
   * even though the `TestRecord` is not what's being built.
   */
  @SuppressWarnings(
    'PMD.CyclomaticComplexity, PMD.EagerlyLoadedDescribeSObjectResult'
  )
  public class Builder {
    private final Schema.SObjectType sObjectType;
    private final Map<Schema.SObjectField, Object> fields = new Map<Schema.SObjectField, Object>();
    private final Map<Schema.SObjectField, SObject> parentRelationships = new Map<Schema.SObjectField, SObject>();
    private final Map<Schema.SObjectField, List<SObject>> childRelationships = new Map<Schema.SObjectField, List<SObject>>();
    private String idPrefix;
    private Boolean allowNullChildToParentRelationship = false;
    private Boolean withoutId = false;
    private Id recordId;

    Map<Schema.SObjectField, Schema.ChildRelationship> fieldToChildRelationship {
      private get {
        if (fieldToChildRelationship == null) {
          fieldToChildRelationship = new Map<Schema.SObjectField, Schema.ChildRelationship>();
          for (
            Schema.ChildRelationship childRelationship : this.sObjectType.getDescribe(
                SObjectDescribeOptions.FULL
              )
              .getChildRelationships()
          ) {
            fieldToChildRelationship.put(
              childRelationship.getField(),
              childRelationship
            );
          }
        }
        return fieldToChildRelationship;
      }
      private set;
    }

    @SuppressWarnings('PMD.EmptyStatementBlock')
    private Builder() {
    }

    private Builder(Schema.SObjectType sObjectType) {
      this.sObjectType = sObjectType;
    }

    /**
     * @description set a field to a value
     * @param field field to set
     * @param value value to set
     * @return the builder
     */
    public TestRecord.Builder setField(
      Schema.SObjectField field,
      Object value
    ) {
      this.fields.put(field, value);
      return this;
    }

    /**
     * @description set a parent relationship to a value
     * @param field relationship to set
     * @param parent value to set
     * @return the builder
     */
    public TestRecord.Builder setParentRelationship(
      Schema.SObjectField field,
      SObject parent
    ) {
      this.parentRelationships.put(field, parent);
      return this;
    }

    /**
     * @description set a parent relationship to a value
     * @param field relationship to set
     * @param builder value to set
     * @return the builder
     */
    public TestRecord.Builder setParentRelationship(
      Schema.SObjectField field,
      TestRecord.Builder builder
    ) {
      return this.setParentRelationship(field, builder.build());
    }

    /**
     * @description set a child relationship to a value
     * @param childRelationshipField relationship to set
     * @param children value to set
     * @return the builder
     */
    public TestRecord.Builder setChildRelationship(
      Schema.SObjectField childRelationshipField,
      List<SObject> children
    ) {
      this.childRelationships.put(childRelationshipField, children);
      return this;
    }

    /**
     * @description denote that we are allowing
     * @return the builder
     */
    public TestRecord.Builder enableNullChildToParentRelationship() {
      this.allowNullChildToParentRelationship = true;
      return this;
    }

    /**
     * @description set a child relationship to a value
     * @param childRelationshipField relationship to set
     * @param builders value to set
     * @return the builder
     */
    public TestRecord.Builder setChildRelationship(
      Schema.SObjectField childRelationshipField,
      List<TestRecord.Builder> builders
    ) {
      List<SObject> children = new List<SObject>();
      for (TestRecord.Builder builder : builders) {
        children.add(builder.build());
      }
      this.childRelationships.put(childRelationshipField, children);
      return this;
    }

    /**
     * @description add a child to a relationship
     * @param childRelationshipField relationship to add to
     * @param child value add
     * @return the builder
     */
    public TestRecord.Builder addToChildRelationship(
      Schema.SObjectField childRelationshipField,
      SObject child
    ) {
      initializeChildRelationship(childRelationshipField);
      this.childRelationships.get(childRelationshipField).add(child);
      return this;
    }

    /**
     * @description add a child to a relationship
     * @param childRelationshipField relationship to add to
     * @param builder value add
     * @return the builder
     */
    public TestRecord.Builder addToChildRelationship(
      Schema.SObjectField childRelationshipField,
      TestRecord.Builder builder
    ) {
      initializeChildRelationship(childRelationshipField);
      this.childRelationships.get(childRelationshipField).add(builder.build());
      return this;
    }

    /**
     * @description sets and Id prefix explicitly.
     * This is to support sObjects like CaseTeamMember where we cannot
     * dynamically calculate the prefix
     * @param idPrefix the prefix to set
     * @return the builder
     */
    public TestRecord.Builder setIdPrefix(String idPrefix) {
      if (idPrefix == null || idPrefix.length() != 3) {
        throw new IllegalArgumentException(
          'idPrefix must be a string with length 3'
        );
      }
      this.idPrefix = idPrefix;
      return this;
    }

    /**
     * @description denote that we should not create an Id on the
     * built record
     * @return the builder
     */
    public TestRecord.Builder withoutId() {
      this.withoutId = true;
      return this;
    }

    /**
     * @description instantiates the record.
     * Uses JSON serialization to set read only fields and relationships
     * @return the built sObject
     */
    public SObject build() {
      this.recordId = generateRecordId();
      Map<String, Object> recordAsMap = generateRecordAsMap();
      populateChildRelationships(recordAsMap);
      populateParentRelationships(recordAsMap);
      return (SObject) JSON.deserialize(
        JSON.serialize(recordAsMap),
        SObject.class
      );
    }

    /**
     * @description instantiates the record, but in a list.
     * @return a list containing the built sObject
     */
    public List<SObject> buildAsList() {
      return new List<SObject>{ this.build() };
    }

    private void initializeChildRelationship(
      Schema.SObjectField childRelationshipField
    ) {
      if (!this.childRelationships.containsKey(childRelationshipField)) {
        this.childRelationships.put(
          childRelationshipField,
          new List<SObject>()
        );
      }
    }

    private Id generateRecordId() {
      return this.withoutId
        ? null
        : this.idPrefix != null
            ? generateIdFromPrefix(idPrefix)
            : getDefaultId();
    }

    private Id getDefaultId() {
      String keyPrefix = this.sObjectType.getDescribe(
          SObjectDescribeOptions.DEFERRED
        )
        .getKeyPrefix();
      if (keyPrefix == null) {
        throw new IllegalArgumentException(
          'You must set an Id prefix when generating record of this sObject type : ' +
          this.sObjectType.getDescribe(SObjectDescribeOptions.DEFERRED)
            .getName()
        );
      }
      return generateIdFromPrefix(keyPrefix);
    }

    private Map<String, Object> generateRecordAsMap() {
      Map<String, Object> recordAsMap = (Map<String, Object>) JSON.deserializeUntyped(
        JSON.serialize(this.sObjectType.newSObject())
      );
      if (this.recordId != null) {
        recordAsMap.put('Id', this.recordId);
      }
      for (Schema.SObjectField sObjectField : fields.keySet()) {
        recordAsMap.put(
          sObjectField.getDescribe().getName(),
          fields.get(sObjectField)
        );
      }
      return recordAsMap;
    }

    private void checkRecordId(Id recordId) {
      if (recordId == null) {
        throw new IllegalArgumentException(
          'Relationships can only be populated when a valid recordId is populated'
        );
      }
    }

    private void populateChildRelationships(Map<String, Object> recordAsMap) {
      if (!this.childRelationships.isEmpty()) {
        checkRecordId(this.recordId);
      }
      for (
        Schema.SObjectField childRelationshipField : this.childRelationships.keySet()
      ) {
        List<SObject> children = this.childRelationships.get(
          childRelationshipField
        );
        for (SObject childRecord : children) {
          checkRecordId(childRecord.Id);
          try {
            childRecord.put(childRelationshipField, this.recordId);
          } catch (System.SObjectException ex) {
            if (!this.allowNullChildToParentRelationship) {
              throw ex;
            }
          }
        }
        recordAsMap.put(
          getChildRelationshipName(childRelationshipField),
          new Map<String, Object>{
            'totalSize' => children.size(),
            'done' => true,
            'records' => children
          }
        );
      }
    }

    private String getChildRelationshipName(
      Schema.SObjectField childRelationshipField
    ) {
      Schema.ChildRelationship childRelationship = this.fieldToChildRelationship.get(
        childRelationshipField
      );
      String childRelationshipName = childRelationship?.getRelationshipName();
      if (childRelationshipName == null) {
        Schema.DescribeFieldResult fieldDescription = childRelationshipField.getDescribe();
        throw new IllegalArgumentException(
          'Invalid child relationship : ' +
            fieldDescription.getSObjectType().getDescribe().getName() +
            '.' +
            fieldDescription.getName()
        );
      }
      return childRelationshipName;
    }

    private void populateParentRelationships(Map<String, Object> recordAsMap) {
      if (!this.parentRelationships.isEmpty()) {
        checkRecordId(this.recordId);
      }
      for (
        Schema.SObjectField relationship : this.parentRelationships.keySet()
      ) {
        SObject parent = this.parentRelationships.get(relationship);
        Schema.DescribeFieldResult relationshipDescription = relationship.getDescribe();
        String parentRelationshipName = relationshipDescription.getRelationshipName();
        String parentRelationshipFieldName = relationshipDescription.getName();
        if (parentRelationshipName == null) {
          throw new IllegalArgumentException(
            'Invalid parent relationship : ' + parentRelationshipFieldName
          );
        }
        checkRecordId(parent.Id);
        recordAsMap.put(parentRelationshipName, parent);
        recordAsMap.put(parentRelationshipFieldName, parent.Id);
      }
    }
  }
}
