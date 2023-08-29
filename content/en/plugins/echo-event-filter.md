---
title: Event Filter Plugin
linkTitle: Event Filter
description: >
  The Event Filter Plugin for Spinnaker filters or trims events sent to external log aggregators by Echo. 
---

![Proprietary](/images/proprietary.svg)

## What the Event Filter plugin does

The Event Filter plugin extends Echo and has the following features: 

1. **Skip** sending an event that Echo normally sends to external log aggregators
2. **Trim** the event before sending it to the log aggregators

The trim and skip functionality uses [JSON Path specification](https://www.ietf.org/archive/id/draft-goessner-dispatch-jsonpath-00.html) syntax.

The default action is to skip the event if the specified condition matches. To do a trim, you have to configure the trim action (`action: TRIM`).

Installing the plugin consists of the following:

1. [Decide what you want to filter or trim](#decide-what-you-want-to-filter)
1. Install in your Spinnaker instance:
   * [Spinnaker managed by the Spinnaker Operator](#install---spinnaker-operator)
   * [Spinnaker managed by Halyard](#install---halyard)

## Compatiblity matrix

| Spinnaker Version | Event Filter Plugin Version |
| ------------------ | -------------------------- |
| 1.30.x              | 0.0.2 |
| 1.29.x              | 0.0.1 |

## {{% heading "prereq" %}}

You should be familiar with the the [_Event types_ section](https://spinnaker.io/docs/setup/other_config/features/notifications/#event-types) of Spinnaker's _Notifications and Events Guide_. That section shows you the structure of an example event and defines `details.type`, `details.application`, and `content.execution`.

<details><summary>Show an example event</summary>

```json
{
    "details": {
      "source": "orca",
      "type": "orca:task:complete",
      "created": "1422487582294",
      "organization": null,
      "project": null,
      "application": "asgard",
      "_content_id": null
    },
    "content": {
      "standalone": true,
      "context": {
        "asgName": "asgard-staging-v048",
        "credentials": "test",
        "deploy.account.name": "test",
        "deploy.server.groups": {},
        "kato.last.task.id": {
          "id": "19351"
        },
        "kato.task.id": {
          "id": "19351"
        },
        "kato.tasks": [
          {
            "history": [
            ],
            "id": "19351",
            "resultObjects": []
          }
        ],
        "notification.type": "enableasg",
        "regions": ["us-west-1"],
        "targetop.asg.enableAsg.name": "asgard-staging-v048",
        "targetop.asg.enableAsg.regions": ["us-west-1"],
        "user": "clin@netflix.com",
        "zones": ["us-west-1a", "us-west-1c"]
      },
      "execution": ...
      "executionId": "62ca5574-0629-419a-b9ac-fb873aa165b2",
      "taskName": "f92239a7-b57a-408d-9d72-3a77484e050b.enableAsg.monitorAsg.9568e7e5-3c37-4699-9e93-f62118adc7c6"
    }
  }
```

</details>

## Decide what you want to filter

Before you install the plugin, you should decide what events you want to filter or trim. You configure these filters as part of the installation process.

### Skip event

The default behavior is to skip sending any event that matches the configured `path` and `pathValue`. 

For example, if you want to skip the event `orca:pipeline:complete`, you need to define the JSON path and the value for that path. In this configuration, when an event has a `details.type` field with the value `orca:pipeline:complete`, Echo does not send the event to the log aggregator.

```yaml
event:
  filters:	    
    - path: details.type
      pathValue: orca:pipeline:complete
```

### Trim event

When you define a `path` and add `action: TRIM`, the Event Filter plugin removes that entry from the event before sending the event to the log aggregator.

In this example, the plugin trims the `context.execution` entry from all events where the field is available. However, Echo still sends the event to the log aggregator.

```yaml
event:
  filters:	    
    - path: content.execution
      action: TRIM
```

The trim feature supports advanced configuration with a predicate. In this example, the event filter plugin removes the `content.execution` field from the events that have the `details.type` equal to `orca:pipeline:starting`.

```yaml
event:
  filters:	    
    - path: content.execution
      predicate: $.details[?(@.type=='orca:pipeline:starting')]
      action: TRIM
```

## Install - Spinnaker Operator

Add a Kustomize patch with the following contents:

```yaml
spec:
  spinnakerConfig:
    profiles:
      echo:
        spinnaker:
          extensibility:
            plugins:
              Armory.EventFilter:
                enabled: true
                version: <version>
            repositories:
              eventfilter:
                enabled: true
                url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
        event:
          filters:
            - <your-filters>
```

1. Replace `<version>` with the plugin version that's compatible with your Spinnaker version. 
1. Add your list of filters. 
1. Add the patch to the `patchesStrategicMerge` section of your kustomization file. 
1. Apply your update.

<details><summary>Show an example with filters</summary>

```yaml
spec:
  spinnakerConfig:
    profiles:
      echo:
        spinnaker:
          extensibility:
            plugins:
              Armory.EventFilter:
                enabled: true
                version: 0.0.2
            repositories:
              eventfilter:
                enabled: true
                url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
        event:
          filters:
            - path: details.type
              pathValue: manual
            - path: details.type
              pathValue: orca:pipeline:complete
            - path: content.standalone
              action: TRIM
            - path: content.execution
              predicate: $.details[?(@.type=='orca:pipeline:starting')]
              action: TRIM
```
</details></br>

Alternately, add the plugin configuration in the `spec.spinnakerConfig.profiles.echo` section of your `spinnakerservice.yml` and then apply your update.

## Install - Halyard

{{% alert color="warning" title="A note about installing plugins in Spinnaker" %}}
When Halyard adds a plugin to a Spinnaker installation, it adds the plugin repository information to all services, not just the ones the plugin is for. This means that when you restart Spinnaker, each service restarts, downloads the plugin, and checks if an extension exists for that service. Each service restarting is not ideal for large Spinnaker installations due to service restart times. To avoid every Spinnaker service restarting and downloading the plugin, do not add the plugin using Halyard. 
{{% /alert %}}

The Event Filter Plugin extends Echo. You should create or update the extended service's local profile in the same directory as the other Halyard configuration files. This is usually `~/.hal/default/profiles` on the machine where Halyard is running.

Add the following to your `echo-local.yml` file:

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.EventFilter:
        enabled: true
        version: <version>
    repositories:
      eventfilter:
        enabled: true
        url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
event:
  filters:
    <your-filters>
```

1. Replace `<version>` with the plugin version that's compatible with your Spinnaker version. 
1. Add your list of filters. 
1. `hal deploy apply` your update.

<details><summary>Show an example with filters</summary>

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.EventFilter:
        enabled: true
        version: 0.0.2
    repositories:
      eventfilter:
        enabled: true
        url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
event:
  filters:
    - path: details.type
      pathValue: manual
    - path: details.type
      pathValue: orca:pipeline:complete
    - path: content.standalone
      action: TRIM
    - path: content.execution
      predicate: $.details[?(@.type=='orca:pipeline:starting')]
      action: TRIM
```

</details></br>

## Release notes

- 0.0.2: 1.30 compatible version
- 0.0.1: Initial release

