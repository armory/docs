---
title: Use Max Concurrent Pipeline Executions
description: >
  Learn how to to throttle the number of maximum parallel pipeline executions.
---

## What max concurrent pipeline executions does

Max concurrent pipeline executions allows you to throttle the number of maximum parallel pipeline executions, so you can configure your pipeline to maximize deployment frequency without encountering any performance degradations or timeouts. This effectively allows you to continue accelerating your deployment frequency and velocity.

If max concurrent pipeline executions is enabled, pipelines queue when the max concurrent pipeline executions is reached. Any queued pipelines are allowed to run once the number of running pipeline executions drops below the max. If the max is set to 0, then pipelines do not queue.

## How to enable and use max concurrent pipeline executions

You can find the max concurrent pipeline executions feature in the your pipeline’s **Configuration** section. It is disabled by default. Uncheck the **Disable concurrent pipeline executions (only run one at a time).** option. Then enter an integer in the **Maximum concurrent pipeline executions** field and save your changes.

