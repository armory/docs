---
title: Configure Clouddriver Caching Agents in Spinnaker
linkTitle: Configure Caching Agents
description: >
  Learn how to configure caching agents in Spinnaker™ to improve Clouddriver performance.
---

## Caching agents in Spinnaker

See the {{< linkWithTitle "caching-agents-concept.md" >}} page for detailed content on caching agents.

Depending on how large your infrastructure is and how many elements it has, you may need to increase Clouddriver's CPU and memory limits, increase the number of running Clouddriver instances, or both.

The following configuration settings affect the behavior of the caching agents and can be used to adjust them depending on the size of the infrastructure being cached. If using the Spinnaker Operator, these settings live under the key `.spec.spinnakerConfig.profiles.clouddriver` of `SpinnakerService` manifest.

### SQL global caching agents configuration

|Key|Description|Default Value|
|----|---|---|
|`sql.scheduler.enabled`|Enable or disable the sql scheduler|false
|`sql.agent.max-concurrent-agents`|Indicates the maximum amount of agents to run at the same time when using the sql scheduler|100
|`sql.agent.disabled-agents`|List of agent names to disable from running|(empty)
|`sql.agent.enabled-pattern`|Regex of agent names enabled for running|.*
|`sql.agent.release-threshold-ms`|Maximum amount of time for releasing agent locks after they finish running. If this value is higher than agent's execution cycle, the agents keep running immediately after finishing|500
|`sql.agent.agent-lock-acquisition-interval-seconds`|How often the scheduler checks for the next batch of agents to run|1
|`sql.agent.poll.interval-seconds`|Default time for how often to run caching agents|30
|`sql.agent.poll.error-interval-seconds`|Default time for when to run caching agents after an execution fails|30
|`sql.agent.poll.timeout-seconds`|Maximum time to hold a lock of an agent execution. If an agent takes longer to finish than this, it's possible to have concurrent executions of the same agent|300

See the {{< linkWithTitle "clouddriver-sql-configure" >}} page for how to configure Clouddriver.

### Redis global caching agents configuration

|Key|Description|Default Value|
|----|---|---|
|`redis.scheduler.enabled`|Enable or disable the redis scheduler|true
|`redis.agent.max-concurrent-agents`|Indicates the maximum amount of agents to run at the same time when using the redis scheduler|1000
|`redis.agent.enabled-pattern`|Regex of agent names enabled for running|.*
|`redis.agent.agent-lock-acquisition-interval-seconds`|How often the scheduler checks for the next batch of agents to run|1
|`redis.poll.interval-seconds`|Default time for how often to run caching agents|30
|`redis.poll.error-interval-seconds`|Default time for when to run caching agents after an execution fails|30
|`redis.poll.timeout-seconds`|Maximum time to hold a lock of an agent execution. If an agent takes longer to finish that this, it's possible to have concurrent executions of the same agent|300

## Considerations

* Using the SQL scheduler has [known issues](https://github.com/spinnaker/spinnaker/issues/5829) where some agents may not be running in some versions of Spinnaker.
* The setting for `max-concurrent-agents` is directly correlated with how much CPU and memory Clouddriver needs to cache infrastructure. Higher values make each replica consume more resources. Higher values also make it possible for Clouddriver to reduce the time spent caching all infrastructure.
