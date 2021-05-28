---
title: spinnaker.execution.stages.before
linkTitle: stages.before
description: policies that are run before executing each task in a particular type of pipeline stage
---
Note: all packages has a corresponding package name that replaces 'before' with 'after'. These 'after' stages are policy checks that are done immediately after stage execution. They are not typically useful, but have the same fields as the 'before' stages.

When writing policies against sub-packages of spinnaker.execution.stages.before, the most interesting data is in the input.stage.context object. The contents of this object corresponds to the JSON you see if you open that stage in the spinnaker UI and click the 'Edit stage as JSON' button.

The contents of custom stages are not covered here, but the fields unique to their context can be identified through the 'Edit as JSON' button in the spinnaker UI.
