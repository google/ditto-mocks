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
 * @description Enables the creation of populated records in memory for use in tests
 */
@IsTest
public class TestUtility {
  private static Integer myNumber = 1;

  /**
   * @description Returns a syntactically correct fake record Id.
   * @param sObjectType The sObjectType for which you would like to generate
   * a fake record Id.
   * @return a fake record Id.
   * @example
   * Case myCase = new Case(Id = TestUtility.getFakeId(Schema.Case.SObjectType));
   */
  public static Id getFakeId(Schema.SObjectType sObjectType) {
    String result = String.valueOf(myNumber++);
    return (Id) (sObjectType.getDescribe(SObjectDescribeOptions.DEFERRED)
      .getKeyPrefix() +
    '0'.repeat(12 - result.length()) +
    result);
  }

  /**
   * @description Adds children record to a parent record.
   * @param parent The parent record you would like to add child records.
   * @param children The collection of children records you would like to
   * relate to the parent record.
   * @param parentSideRelationshipName The name of the relationship from
   * parent to child.
   * @return an object with children attached in memory.
   * @example
   * Opportunity opp = new Opportunity();
   * opp = (Opportunity) TestUtility.attachListToParent(
   *   opp,
   *   new List<OpportunityLineItem>{
   *     new OpportunityLineItem(
   *       Name = 'My Product',
   *       Quantity = 10
   *     )
   *   },
   * 'OpportunityLineItems',
   * );
   */
  public static SObject attachListToParent(
    SObject parent,
    List<SObject> children,
    String parentSideRelationshipName
  ) {
    String targetJson = JSON.serialize(parent);

    String childrenJson = '"' + parentSideRelationshipName + '" : {';
    childrenJson += '"totalSize" : ' + children.size() + ',';
    childrenJson += '"done" : true,';
    childrenJson += '"records" : ' + JSON.serialize(children);
    childrenJson += '}';

    targetJson =
      targetJson.substring(0, targetJson.length() - 1) +
      ',' +
      childrenJson +
      '}';

    return (SObject) JSON.deserialize(targetJson, SObject.class);
  }

  /**
   * @description Sets a read only field.
   * @param record The record which you would like to set a read-only field for.
   * @param fieldName The API name of the field you would like to set.
   * @param value The value you would like to set it to.
   * @return the object with the read only field populated.
   * @example
   * ProcessInstanceWorkitem workItem = new ProcessInstanceWorkitem();
   * workItem = (ProcessInstanceWorkitem) TestUtility.setReadOnlyField(
   *   workItem,
   *   'ElapsedTimeInHours',
   *   10
   * );
   */
  public static SObject setReadOnlyField(
    SObject record,
    String fieldName,
    Object value
  ) {
    return setReadOnlyFields(
      record,
      new Map<String, Object>{ fieldName => value }
    );
  }

  /**
   * @description Sets read only fields.
   * @param record The record which you would like to set the read-only field for.
   * @param changesToFields  Map of field API name => value for the fields
   * you wish to set.
   * @return the record with read only fields populated.
   * @example
   * ProcessInstanceWorkitem workItem = new ProcessInstanceWorkitem();
   * workItem = (ProcessInstanceWorkitem) TestUtility.setReadOnlyField(
   *   workItem,
   *   new Map<String, Object>{
   *     'ElapsedTimeInHours' => 10
   *   }
   * );
   */
  public static SObject setReadOnlyFields(
    SObject record,
    Map<String, Object> changesToFields
  ) {
    String serializedRecord = JSON.serialize(record);
    Map<String, Object> deserializedRecordMap = (Map<String, Object>) JSON.deserializeUntyped(
      serializedRecord
    );

    for (String sObjectField : changesToFields.keySet()) {
      deserializedRecordMap.put(
        sObjectField,
        changesToFields.get(sObjectField)
      );
    }

    serializedRecord = JSON.serialize(deserializedRecordMap);
    return (SObject) JSON.deserialize(serializedRecord, SObject.class);
  }
}
