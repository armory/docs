---
title: spinnaker.execution.stages.before
linkTitle: stages.before
description: "Policies that are run before executing each task in a particular type of pipeline stage."
weight: 10
---
> **Note:** all packages listed below have a corresponding package name that replaces `before` with `after`. These "after" stages are policy checks that are done immediately after stage execution. They are not typically useful but have the same fields as the "before" stages.

When writing policies against sub-packages of `spinnaker.execution.stages.before`, the most interesting data is in the `input.stage.context` object. The contents of this object corresponds to the JSON you see if you open that stage in the UI and click the **Edit stage as JSON** button.

If you write your own custom stages they will also make policy checks, but the contents of custom stages are not covered here. The package name for custom stages is `spinnaker.execution.stages.before.<stageType>`. The fields unique to their context can be identified through the **Edit stage as JSON** button in the UI.
