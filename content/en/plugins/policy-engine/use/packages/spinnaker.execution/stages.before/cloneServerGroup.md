---
title: "spinnaker.execution.stages.before.cloneServerGroup"
linktitle: "cloneServerGroup"
description: "A policy targeting this object runs before executing each task in a cloneServerGroup stage."
weight: 10
---
More information on the clone server group stage can be found in Spinnaker's [documentation](https://spinnaker.io/reference/pipeline/stages/#clone-server-group).

## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "pipeline": {
      "application": "test",
      "authentication": {
        "allowedAccounts": [
          "spinnaker",
          "staging",
          "staging-ecs"
        ],
        "user": "myUserName"
      },
      "buildTime": 1620926703486,
      "canceled": false,
      "canceledBy": null,
      "cancellationReason": null,
      "description": null,
      "endTime": 1620926705283,
      "id": "01F5KC59TRGWKCP31C4N51CDSB",
      "initialConfig": {},
      "keepWaitingPipelines": false,
      "limitConcurrent": true,
      "name": "test",
      "notifications": [],
      "origin": "api",
      "partition": null,
      "paused": null,
      "pipelineConfigId": "6a4cff2e-8265-4584-8993-2da2eb6254f5",
      "source": null,
      "spelEvaluator": "v4",
      "stages": [],
      "startTime": 1620926703525,
      "startTimeExpiry": null,
      "status": "TERMINAL",
      "systemNotifications": [],
      "templateVariables": null,
      "trigger": {
        "artifacts": [
          {
            "artifactAccount": "myUserName",
            "customKind": false,
            "location": null,
            "metadata": {
              "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
            },
            "name": "manifests/deploy-spinnaker.yaml",
            "provenance": null,
            "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
            "type": "github/file",
            "uuid": null,
            "version": "master"
          }
        ],
        "correlationId": null,
        "isDryRun": false,
        "isRebake": false,
        "isStrategy": false,
        "notifications": [],
        "other": {
          "artifacts": [
            {
              "artifactAccount": "myUserName",
              "customKind": false,
              "metadata": {
                "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "version": "master"
            }
          ],
          "dryRun": false,
          "enabled": false,
          "eventId": "c1090782-f485-490e-a2d7-31763b3bd4d8",
          "executionId": "01F5KC59TRGWKCP31C4N51CDSB",
          "expectedArtifacts": [
            {
              "boundArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "defaultArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "id": "05ad020e-73a6-49f2-9988-2073831219e9",
              "matchArtifact": {
                "artifactAccount": "myUserName",
                "customKind": true,
                "metadata": {
                  "id": "f7a9b229-0a23-42ab-82de-9990d77084df"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "type": "github/file"
              },
              "useDefaultArtifact": true,
              "usePriorArtifact": false
            }
          ],
          "notifications": [],
          "parameters": {},
          "preferred": false,
          "rebake": false,
          "resolvedExpectedArtifacts": [
            {
              "boundArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "defaultArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "id": "05ad020e-73a6-49f2-9988-2073831219e9",
              "matchArtifact": {
                "artifactAccount": "myUserName",
                "customKind": true,
                "metadata": {
                  "id": "f7a9b229-0a23-42ab-82de-9990d77084df"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "type": "github/file"
              },
              "useDefaultArtifact": true,
              "usePriorArtifact": false
            }
          ],
          "strategy": false,
          "type": "manual",
          "user": "myUserName"
        },
        "parameters": {},
        "resolvedExpectedArtifacts": [
          {
            "boundArtifact": {
              "artifactAccount": "myUserName",
              "customKind": false,
              "location": null,
              "metadata": {
                "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "provenance": null,
              "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "uuid": null,
              "version": "master"
            },
            "defaultArtifact": {
              "artifactAccount": "myUserName",
              "customKind": false,
              "location": null,
              "metadata": {
                "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "provenance": null,
              "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "uuid": null,
              "version": "master"
            },
            "id": "05ad020e-73a6-49f2-9988-2073831219e9",
            "matchArtifact": {
              "artifactAccount": "myUserName",
              "customKind": true,
              "location": null,
              "metadata": {
                "id": "f7a9b229-0a23-42ab-82de-9990d77084df"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "provenance": null,
              "reference": null,
              "type": "github/file",
              "uuid": null,
              "version": null
            },
            "useDefaultArtifact": true,
            "usePriorArtifact": false
          }
        ],
        "type": "manual",
        "user": "myUserName"
      },
      "type": "PIPELINE"
    },
    "stage": {
      "context": {
        "application": "test",
        "attempt": 2,
        "cloudProvider": "aws",
        "cloudProviderType": "aws",
        "consecutiveNotFound": 0,
        "copySourceCustomBlockDeviceMappings": false,
        "credentials": "staging",
        "freeFormDetails": "",
        "lastException": "Unable to locate current_asg_dynamic in staging/us-east-2/test\ncom.netflix.spinnaker.orca.clouddriver.pipeline.servergroup.support.TargetServerGroup$NotFoundException: Unable to locate current_asg_dynamic in staging/us-east-2/test\n\tat java.base/jdk.internal.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)\n\tat java.base/jdk.internal.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62)\n\tat java.base/jdk.internal.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45)\n\tat java.base/java.lang.reflect.Constructor.newInstance(Constructor.java:490)\n\tat org.codehaus.groovy.reflection.CachedConstructor.invoke(CachedConstructor.java:80)\n\tat org.codehaus.groovy.reflection.CachedConstructor.doConstructorInvoke(CachedConstructor.java:74)\n\tat org.codehaus.groovy.runtime.callsite.ConstructorSite$ConstructorSiteNoUnwrap.callConstructor(ConstructorSite.java:84)\n\tat org.codehaus.groovy.runtime.callsite.CallSiteArray.defaultCallConstructor(CallSiteArray.java:59)\n\tat org.codehaus.groovy.runtime.callsite.AbstractCallSite.callConstructor(AbstractCallSite.java:237)\n\tat org.codehaus.groovy.runtime.callsite.AbstractCallSite.callConstructor(AbstractCallSite.java:249)\n\tat com.netflix.spinnaker.orca.clouddriver.pipeline.servergroup.support.TargetServerGroupResolver.resolveByTarget(TargetServerGroupResolver.groovy:75)\n\tat java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n\tat java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n\tat java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:566)\n\tat org.codehaus.groovy.reflection.CachedMethod.invoke(CachedMethod.java:101)\n\tat groovy.lang.MetaMethod.doMethodInvoke(MetaMethod.java:323)\n\tat org.codehaus.groovy.runtime.metaclass.ClosureMetaClass.invokeMethod(ClosureMetaClass.java:351)\n\tat org.codehaus.groovy.runtime.callsite.PogoMetaClassSite.callCurrent(PogoMetaClassSite.java:64)\n\tat org.codehaus.groovy.runtime.callsite.CallSiteArray.defaultCallCurrent(CallSiteArray.java:51)\n\tat org.codehaus.groovy.runtime.callsite.AbstractCallSite.callCurrent(AbstractCallSite.java:156)\n\tat org.codehaus.groovy.runtime.callsite.AbstractCallSite.callCurrent(AbstractCallSite.java:176)\n\tat com.netflix.spinnaker.orca.clouddriver.pipeline.servergroup.support.TargetServerGroupResolver$_resolveByParams_closure1.doCall(TargetServerGroupResolver.groovy:56)\n\tat java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n\tat java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n\tat java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:566)\n\tat org.codehaus.groovy.reflection.CachedMethod.invoke(CachedMethod.java:101)\n\tat groovy.lang.MetaMethod.doMethodInvoke(MetaMethod.java:323)\n\tat org.codehaus.groovy.runtime.metaclass.ClosureMetaClass.invokeMethod(ClosureMetaClass.java:263)\n\tat groovy.lang.MetaClassImpl.invokeMethod(MetaClassImpl.java:1041)\n\tat groovy.lang.Closure.call(Closure.java:405)\n\tat groovy.lang.Closure.call(Closure.java:421)\n\tat org.codehaus.groovy.runtime.DefaultGroovyMethods.collect(DefaultGroovyMethods.java:3574)\n\tat org.codehaus.groovy.runtime.DefaultGroovyMethods.collect(DefaultGroovyMethods.java:3559)\n\tat org.codehaus.groovy.runtime.DefaultGroovyMethods.collect(DefaultGroovyMethods.java:3659)\n\tat org.codehaus.groovy.runtime.dgm$87.invoke(Unknown Source)\n\tat org.codehaus.groovy.runtime.callsite.PojoMetaMethodSite$PojoMetaMethodSiteNoUnwrapNoCoerce.invoke(PojoMetaMethodSite.java:244)\n\tat org.codehaus.groovy.runtime.callsite.PojoMetaMethodSite.call(PojoMetaMethodSite.java:53)\n\tat org.codehaus.groovy.runtime.callsite.CallSiteArray.defaultCall(CallSiteArray.java:47)\n\tat org.codehaus.groovy.runtime.callsite.AbstractCallSite.call(AbstractCallSite.java:115)\n\tat org.codehaus.groovy.runtime.callsite.AbstractCallSite.call(AbstractCallSite.java:127)\n\tat com.netflix.spinnaker.orca.clouddriver.pipeline.servergroup.support.TargetServerGroupResolver.resolveByParams(TargetServerGroupResolver.groovy:54)\n\tat com.netflix.spinnaker.orca.kato.pipeline.support.SourceResolver.getSource(SourceResolver.groovy:79)\n\tat com.netflix.spinnaker.orca.kato.pipeline.support.SourceResolver$getSource.call(Unknown Source)\n\tat org.codehaus.groovy.runtime.callsite.CallSiteArray.defaultCall(CallSiteArray.java:47)\n\tat org.codehaus.groovy.runtime.callsite.AbstractCallSite.call(AbstractCallSite.java:115)\n\tat org.codehaus.groovy.runtime.callsite.AbstractCallSite.call(AbstractCallSite.java:127)\n\tat com.netflix.spinnaker.orca.kato.pipeline.strategy.DetermineSourceServerGroupTask.execute(DetermineSourceServerGroupTask.groovy:59)\n\tat com.netflix.spinnaker.orca.q.handler.RunTaskHandler$handle$1$1$1.invoke(RunTaskHandler.kt:144)\n\tat com.netflix.spinnaker.orca.q.handler.RunTaskHandler$handle$1$1$1.invoke(RunTaskHandler.kt:75)\n\tat com.netflix.spinnaker.orca.q.handler.RunTaskHandler.withLoggingContext(RunTaskHandler.kt:419)\n\tat com.netflix.spinnaker.orca.q.handler.RunTaskHandler.access$withLoggingContext(RunTaskHandler.kt:75)\n\tat com.netflix.spinnaker.orca.q.handler.RunTaskHandler$handle$1$1.invoke(RunTaskHandler.kt:105)\n\tat com.netflix.spinnaker.orca.q.handler.RunTaskHandler$handle$1$1.invoke(RunTaskHandler.kt:75)\n\tat com.netflix.spinnaker.orca.q.handler.AuthenticationAware$sam$java_util_concurrent_Callable$0.call(AuthenticationAware.kt)\n\tat com.netflix.spinnaker.security.AuthenticatedRequest.lambda$wrapCallableForPrincipal$0(AuthenticatedRequest.java:272)\n\tat com.netflix.spinnaker.orca.q.handler.AuthenticationAware$DefaultImpls.withAuth(AuthenticationAware.kt:51)\n\tat com.netflix.spinnaker.orca.q.handler.RunTaskHandler.withAuth(RunTaskHandler.kt:75)\n\tat com.netflix.spinnaker.orca.q.handler.RunTaskHandler$handle$1.invoke(RunTaskHandler.kt:104)\n\tat com.netflix.spinnaker.orca.q.handler.RunTaskHandler$handle$1.invoke(RunTaskHandler.kt:75)\n\tat com.netflix.spinnaker.orca.q.handler.RunTaskHandler$withTask$1.invoke(RunTaskHandler.kt:247)\n\tat com.netflix.spinnaker.orca.q.handler.RunTaskHandler$withTask$1.invoke(RunTaskHandler.kt:75)\n\tat com.netflix.spinnaker.orca.q.handler.OrcaMessageHandler$withTask$1.invoke(OrcaMessageHandler.kt:68)\n\tat com.netflix.spinnaker.orca.q.handler.OrcaMessageHandler$withTask$1.invoke(OrcaMessageHandler.kt:46)\n\tat com.netflix.spinnaker.orca.q.handler.OrcaMessageHandler$withStage$1.invoke(OrcaMessageHandler.kt:85)\n\tat com.netflix.spinnaker.orca.q.handler.OrcaMessageHandler$withStage$1.invoke(OrcaMessageHandler.kt:46)\n\tat com.netflix.spinnaker.orca.q.handler.OrcaMessageHandler$DefaultImpls.withExecution(OrcaMessageHandler.kt:95)\n\tat com.netflix.spinnaker.orca.q.handler.RunTaskHandler.withExecution(RunTaskHandler.kt:75)\n\tat com.netflix.spinnaker.orca.q.handler.OrcaMessageHandler$DefaultImpls.withStage(OrcaMessageHandler.kt:74)\n\tat com.netflix.spinnaker.orca.q.handler.RunTaskHandler.withStage(RunTaskHandler.kt:75)\n\tat com.netflix.spinnaker.orca.q.handler.OrcaMessageHandler$DefaultImpls.withTask(OrcaMessageHandler.kt:60)\n\tat com.netflix.spinnaker.orca.q.handler.RunTaskHandler.withTask(RunTaskHandler.kt:75)\n\tat com.netflix.spinnaker.orca.q.handler.RunTaskHandler.withTask(RunTaskHandler.kt:236)\n\tat com.netflix.spinnaker.orca.q.handler.RunTaskHandler.handle(RunTaskHandler.kt:101)\n\tat com.netflix.spinnaker.orca.q.handler.RunTaskHandler.handle(RunTaskHandler.kt:75)\n\tat com.netflix.spinnaker.q.MessageHandler$DefaultImpls.invoke(MessageHandler.kt:36)\n\tat com.netflix.spinnaker.orca.q.handler.OrcaMessageHandler$DefaultImpls.invoke(OrcaMessageHandler.kt)\n\tat com.netflix.spinnaker.orca.q.handler.RunTaskHandler.invoke(RunTaskHandler.kt:75)\n\tat com.netflix.spinnaker.orca.q.audit.ExecutionTrackingMessageHandlerPostProcessor$ExecutionTrackingMessageHandlerProxy.invoke(ExecutionTrackingMessageHandlerPostProcessor.kt:72)\n\tat com.netflix.spinnaker.q.QueueProcessor$callback$1$1.run(QueueProcessor.kt:90)\n\tat java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128)\n\tat java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628)\n\tat java.base/java.lang.Thread.run(Thread.java:834)\n",
        "region": "us-east-2",
        "stack": "",
        "target": "current_asg_dynamic",
        "targetCluster": "test",
        "useAmiBlockDeviceMappings": false,
        "useSourceCapacity": true
      },
      "endTime": null,
      "id": "01F5KC59VXW75H7Q7Z2C87CXET",
      "lastModified": null,
      "name": "Clone Server Group",
      "outputs": {},
      "parentStageId": null,
      "refId": "12",
      "requisiteStageRefIds": [],
      "scheduledTime": null,
      "startTime": 1620926703580,
      "startTimeExpiry": null,
      "status": "RUNNING",
      "syntheticStageOwner": null,
      "tasks": [
        {
          "endTime": null,
          "id": "1",
          "implementingClass": "com.netflix.spinnaker.orca.kato.pipeline.strategy.DetermineSourceServerGroupTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "determineSourceServerGroup",
          "stageEnd": false,
          "stageStart": true,
          "startTime": 1620926703830,
          "status": "RUNNING"
        },
        {
          "endTime": null,
          "id": "2",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.DetermineHealthProvidersTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "determineHealthProviders",
          "stageEnd": false,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        },
        {
          "endTime": null,
          "id": "3",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.pipeline.providers.aws.CaptureSourceServerGroupCapacityTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "snapshotSourceServerGroup",
          "stageEnd": false,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        },
        {
          "endTime": null,
          "id": "4",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.servergroup.CloneServerGroupTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "cloneServerGroup",
          "stageEnd": false,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        },
        {
          "endTime": null,
          "id": "5",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.MonitorKatoTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "monitorDeploy",
          "stageEnd": false,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        },
        {
          "endTime": null,
          "id": "6",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.servergroup.ServerGroupCacheForceRefreshTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "forceCacheRefresh",
          "stageEnd": false,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        },
        {
          "endTime": null,
          "id": "7",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.instance.WaitForUpInstancesTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "waitForUpInstances",
          "stageEnd": false,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        },
        {
          "endTime": null,
          "id": "8",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.servergroup.ServerGroupCacheForceRefreshTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "forceCacheRefresh",
          "stageEnd": false,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        },
        {
          "endTime": null,
          "id": "9",
          "implementingClass": "com.netflix.spinnaker.orca.igor.tasks.GetCommitsTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "getCommits",
          "stageEnd": true,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        }
      ],
      "type": "cloneServerGroup"
    },
    "user": {
      "isAdmin": false,
      "roles": [],
      "username": "myUserName"
    }
  }
}

```
</details>

## Example Policy

{{< prism lang="rego" line-numbers="true" >}}
package spinnaker.execution.stages.before.cloneServerGroup

productionAccounts :=["prod1","prod2"]

deny["ASGs running in production must have a minimum of 2 instances to avoid having a single point of failure."]{
	input.stage.context.credentials==productionAccounts[_]
    input.stage.context.useSourceCapacity==false
    object.get(input.stage.context.capacity,"min",0)<2
}{
	input.stage.context.credentials==productionAccounts[_]
    input.stage.context.useSourceCapacity==false
    object.get(input.stage.context,"capacity",null)==null
}
{{< /prism >}}

## Keys

Parameters related to the stage against which the policy is executing can be found in the [input.stage.context](#inputstagecontext) object.

### input.pipeline

| Key                                               | Type      | Description                                                                                                                           |
| ------------------------------------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| `input.pipeline.application`                      | `string`  | The name of the Spinnaker application to which this pipeline belongs.                                                                 |
| `input.pipeline.authentication.allowedAccounts[]` | `string`  | The list of accounts to which the user this stage runs as has access.                                                                 |
| `input.pipeline.authentication.user`              | `string`  | The Spinnaker user initiating the change.                                                                                             |
| `input.pipeline.buildTime`                        | `number`  |                                                                                                                                       |
| `input.pipeline.canceled`                         | `boolean` |                                                                                                                                       |
| `input.pipeline.canceledBy`                       |           |                                                                                                                                       |
| `input.pipeline.cancellationReason`               |           |                                                                                                                                       |
| `input.pipeline.description`                      | `string`  | Description of the pipeline defined in the UI.                                                                                        |
| `input.pipeline.endTime`                          | `number`  |                                                                                                                                       |
| `input.pipeline.id`                               | `string`  | The unique ID of the pipeline.                                                                                                        |
| `input.pipeline.keepWaitingPipelines`             | `boolean` | If false and concurrent pipeline execution is disabled, then the pipelines in the waiting queue gets canceled when the next execution starts. |
| `input.pipeline.limitConcurrent`                  | `boolean` | True if only 1 concurrent execution of this pipeline is allowed.                                                                      |
| `input.pipeline.name`                             | `string`  | The name of this pipeline.                                                                                                            |
| `input.pipeline.origin`                           | `string`  |                                                                                                                                       |
| `input.pipeline.partition`                        |           |                                                                                                                                       |
| `input.pipeline.paused`                           |           |                                                                                                                                       |
| `input.pipeline.pipelineConfigId`                 | `string`  |                                                                                                                                       |
| `input.pipeline.source`                           |           |                                                                                                                                       |
| `input.pipeline.spelEvaluator`                    | `string`  | Which version of spring expression language is being used to evaluate SpEL.                                                           |
| `input.pipeline.stages[]`                         | `[array]` | An array of the stages in the pipeline. Typically if you are writing a policy that examines multiple pipeline stages, it is better to write that policy against either the `opa.pipelines package`, or the `spinnaker.execution.pipelines.before` package. |
| `input.pipeline.startTime`                        | `number`  | Timestamp from when the pipeline was started.                                                                                         |
| `input.pipeline.startTimeExpiry`                  | `date `   | Unix epoch date at which the pipeline expires.                                                                                    |
| `input.pipeline.status`                           | `string`  |                                                                                                                                       |
| `input.pipeline.templateVariables`                |           |                                                                                                                                       |
| `input.pipeline.type`                             | `string`  |                                                                                                                                       |

### input.pipeline.trigger

See [input.pipeline.trigger]({{< ref "input.pipeline.trigger.md" >}}) for more information.

### input.stage

See [`input.stage`]({{< ref "input.stage.md" >}}) for more information.

### input.stage.context

| Key                                                       | Type      | Description                                                                                           |
| --------------------------------------------------------- | --------- | ----------------------------------------------------------------------------------------------------- |
| `input.stage.context.application`                         | `string`  | The name of the Spinnaker application for this pipeline.                                              |
| `input.stage.context.attempt`                             | `number`  | How many times has this stage attempted to execute.                                                   |
| `input.stage.context.capacity.desired`                    | `number`  | If `useSourceCapacity` is false, the desired number of instances to run in the group.                 |
| `input.stage.context.capacity.max`                        | `number`  | If `useSourceCapacity` is false, the maximum number of instances to run in the group.                 |
| `input.stage.context.capacity.min`                        | `number`  | If `useSourceCapacity` is false, the minimum number of instances to run in the group.                 |
| `input.stage.context.cloudProvider`                       | `string`  | The name of the cloud provider that executes the stage.                                           |
| `input.stage.context.cloudProviderType`                   | `string`  | The type of the cloud provider that executes the stage.                                           |
| `input.stage.context.consecutiveNotFound`                 | `number`  |                                                                                                       |
| `input.stage.context.copySourceCustomBlockDeviceMappings` | `boolean` |                                                                                                       |
| `input.stage.context.credentials`                         | `string`  | The account/credential set that's used to execute this stage.                                   |
| `input.stage.context.freeFormDetails`                     | `string`  |                                                                                                       |
| `input.stage.context.lastException`                       | `string`  | The last exception that occurred when executing this stage.                                           |
| `input.stage.context.region`                              | `string`  | The region in which the new server group is deployed.                                            |
| `input.stage.context.stack`                               | `string`  |                                                                                                       |
| `input.stage.context.target`                              | `string`  | Which server group should be selected when this stage starts.                                         |
| `input.stage.context.targetCluster`                       | `string`  | The cluster that contains the target.                                                                 |
| `input.stage.context.useAmiBlockDeviceMappings`           | `boolean` | Spinnaker will use the block device mappings from the selected AMI when deploying a new server group. |
| `input.stage.context.useSourceCapacity`                   | `boolean` | Spinnaker will use the current capacity of the existing server group when deploying a new server group. This setting is intended to support a server group with auto-scaling enabled, where the bounds and desired capacity are controlled by an external process. In the event that there is no existing server group, the deploy will fail. |

### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.
