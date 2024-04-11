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
 * @description Tests for DML
 */
@IsTest(isParallel=true)
private class DMLTest {
  private static Task deletedTask;
  private static Task existingTask;
  private static Task newTask;

  private static List<Task> deletedTasks;
  private static List<Task> existingTasks;
  private static List<Task> newTasks;

  private static DML myDml = new DML();

  static {
    newTask = new Task();
    newTasks = new List<Task>{ newTask };

    existingTask = new Task();
    insert existingTask;
    existingTasks = new List<Task>{ existingTask };

    deletedTask = new Task();
    insert deletedTask;
    delete deletedTask;
    deletedTasks = new List<Task>{ deletedTask };
  }

  @IsTest
  private static void doDeleteOnSingleRecordShouldReturnValidResults() {
    System.assertNotEquals(
      null,
      myDml.doDelete(existingTask, true),
      'doDelete should return valid results'
    );
  }

  @IsTest
  private static void doDeleteOnMultipleRecordsShouldReturnValidResults() {
    System.assertNotEquals(
      null,
      myDml.doDelete(existingTasks, true),
      'doDelete should return valid results'
    );
  }

  @IsTest
  private static void doDeleteImmediateOnMultipleRecordsShouldReturnValidResults() {
    System.assertNotEquals(
      null,
      myDml.doDeleteImmediate(existingTasks),
      'doDeleteImmediate should return valid results'
    );
  }

  @IsTest
  private static void doInsertOnSingleRecordShouldReturnValidResults() {
    System.assertNotEquals(
      null,
      myDml.doInsert(newTask, true),
      'doInsert should return valid results'
    );
  }

  @IsTest
  private static void doInsertOnMultipleRecordsShouldReturnValidResults() {
    System.assertNotEquals(
      null,
      myDml.doInsert(newTasks, true),
      'doInsert should return valid results'
    );
  }

  @IsTest
  private static void doInsertWithDmlOptionsOnSingleRecordShouldReturnValidResults() {
    System.assertNotEquals(
      null,
      myDml.doInsert(newTask, new Database.DMLOptions()),
      'doInsert should return valid results'
    );
  }

  @IsTest
  private static void doInsertWithDmlOptionsOnMultipleRecordsShouldReturnValidResults() {
    System.assertNotEquals(
      null,
      myDml.doInsert(newTasks, new Database.DMLOptions()),
      'doInsert should return valid results'
    );
  }

  @IsTest
  private static void doUpdateOnSingleRecordShouldReturnValidResults() {
    System.assertNotEquals(
      null,
      myDml.doUpdate(existingTask, true),
      'doUpdate should return valid results'
    );
  }

  @IsTest
  private static void doUpdateOnMultipleRecordsShouldReturnValidResults() {
    System.assertNotEquals(
      null,
      myDml.doUpdate(existingTasks, true),
      'doUpdate should return valid results'
    );
  }

  @IsTest
  private static void doUpdateWithDmlOptionsOnSingleRecordShouldReturnValidResults() {
    System.assertNotEquals(
      null,
      myDml.doUpdate(existingTask, new Database.DMLOptions()),
      'doUpdate should return valid results'
    );
  }

  @IsTest
  private static void doUpdateWithDmlOptionsOnMultipleRecordsShouldReturnValidResults() {
    System.assertNotEquals(
      null,
      myDml.doUpdate(existingTasks, new Database.DMLOptions()),
      'doUpdate should return valid results'
    );
  }

  @IsTest
  private static void doUpsertOnSingleRecordShouldReturnValidResults() {
    System.assertNotEquals(
      null,
      myDml.doUpsert(newTask, Task.Fields.Id, true),
      'doUpsert should return valid results'
    );
  }

  @IsTest
  private static void doUpsertOnMultipleRecordsShouldReturnValidResults() {
    System.assertNotEquals(
      null,
      myDml.doUpsert(newTasks, Task.Fields.Id, true),
      'doUpsert should return valid results'
    );
  }

  @IsTest
  private static void doUndeleteOnSingleRecordShouldReturnValidResults() {
    System.assertNotEquals(
      null,
      myDml.doUndelete(deletedTask, true),
      'doUndelete should return valid results'
    );
  }

  @IsTest
  private static void doUndeleteOnMultipleRecordsShouldReturnValidResults() {
    System.assertNotEquals(
      null,
      myDml.doUndelete(deletedTasks, true),
      'doUndelete should return valid results'
    );
  }

  @IsTest
  private static void doUndeleteOnSingleRecordIdShouldReturnValidResults() {
    System.assertNotEquals(
      null,
      myDml.doUndelete(deletedTask.Id, true),
      'doUndelete should return valid results'
    );
  }

  @IsTest
  private static void doUndeleteOnMultipleRecordIdsShouldReturnValidResults() {
    System.assertNotEquals(
      null,
      myDml.doUndelete(new List<Id>{ deletedTask.Id }, true),
      'doUndelete should return valid results'
    );
  }
}
