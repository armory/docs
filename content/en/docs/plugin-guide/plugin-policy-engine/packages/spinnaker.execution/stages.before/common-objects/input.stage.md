---
title: "input.stage"
linkTitle: "input.stage"
description: "The `input.stage` object is present in most `spinnaker.execution.stages.before` packages."
---


| Key                                     | Type      | Description                                                                                               |
| --------------------------------------- | --------- | --------------------------------------------------------------------------------------------------------- |
| `input.stage.endTime`                   | ` `       | The time at which the stage finished executing. This will be blank since the stage has not yet completed. |
| `input.stage.id`                        | `string`  | The unique ID for the stage.                                                                              |
| `input.stage.lastModified`              | ` `       | When the stage was last modified.                                                                         |
| `input.stage.name`                      | `string`  | The name of the stage.                                                                                    |
| `input.stage.parentStageId`             | `string`  |                                                                                                           |
| `input.stage.refId`                     | `string`  |                                                                                                           |
| `input.stage.scheduledTime`             | `number`  |                                                                                                           |
| `input.stage.startTime`                 | `number`  | The timestamp at which the stage started                                                                  |
| `input.stage.startTimeExpiry`           | ` `       |                                                                                                           |
| `input.stage.status`                    | `string`  | The stages status, this will typically be 'running' when this policy is evaluated.                        |
| `input.stage.syntheticStageOwner`       | `string`  |                                                                                                           |
| `input.stage.tasks[].endTime`           | `number`  | The time at which the task finished executing.                                                            |
| `input.stage.tasks[].id`                | `string`  |                                                                                                           |
| `input.stage.tasks[].implementingClass` | `string`  | The name of the spinnaker class that implements this task.                                                |
| `input.stage.tasks[].loopEnd`           | `boolean` |                                                                                                           |
| `input.stage.tasks[].loopStart`         | `boolean` |                                                                                                           |
| `input.stage.tasks[].name`              | `string`  | The tasks name                                                                                            |
| `input.stage.tasks[].stageEnd`          | `boolean` |                                                                                                           |
| `input.stage.tasks[].stageStart`        | `boolean` |                                                                                                           |
| `input.stage.tasks[].startTime`         | `number`  | The time at which the task started exeucting.                                                             |
| `input.stage.tasks[].status`            | `string`  | The status of the task.                                                                                   |
| `input.stage.type`                      | `string`  | The type of the stage, always 'bake'                                                                      |