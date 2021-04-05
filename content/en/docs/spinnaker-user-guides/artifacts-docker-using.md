---
title: Use Docker Images in Spinnaker
linkTitle: Use Docker Images
aliases:
  - /spinnaker_user_guides/docker/
  - /docs/spinnaker-user-guides/docker/
description: >
  Learn how to use Docker images in your Spinnaker pipeline.
---

## Triggering a pipeline with a Docker Registry update

> Before you start, you need to [configure a Docker
registry]({{< ref "artifacts-docker-connect" >}}). If you don't see your
Docker registry as an option, or you're missing your organization or image in
the UI, you'll need to double-check your Spinnaker is configured to use that
registry (and/or repository).

To add a Docker trigger to your pipeline, go to your configurations stage and
select "Add Trigger", then select "Docker Registry" from the Type dropdown
menu. You should then be able to select the Registry to use, and find your
Organization(s) and Image(s).

The Tag field is optional; if left empty, any new Docker image posted to the
registry (for that image) will trigger the pipeline.  You can enter a regular
expression here to limit triggering to tag pattern names (for example,
`master-.*` will only trigger when a new image with a tag starting with
"master-" is uploaded).

{{< include "regex_vs_wildcard.md" >}}

![Add Trigger](/images/docker-user-guide-1.gif)

## Referencing the new image

When a new Docker image (that matches the Tag pattern, if set) is detected,
the Docker Registry trigger will fill in some context, which can be used
in [SpEL Expressions](https://www.spinnaker.io/guides/user/pipeline/expressions/)
elsewhere in the pipeline (for example, in a Kubernetes manifest).

If you click on the `Source` link for the pipeline that was triggered, you
can find the `trigger` section of the JSON.  Below is a partial block of
JSON as an example of the fields that will be filled in.

```json
  "trigger": {
    "account": "my-docker-registry",
    "artifacts": [
      {
        "name": "index.docker.io/armory/demoapp",
        "reference": "index.docker.io/armory/demoapp:master-29",
        "type": "docker/image",
        "version": "master-29"
      }
    ],
    "repository": "armory/demoapp",
    "tag": "master-29",
    "type": "docker",
  },
```

You can reference the Docker tag that triggered the pipeline with the
expression `${trigger['tag']}`, which may be all you need, as in this
image spec line from a Kubernetes manifest:

```bash
- image: "docker.io/armory/demoapp:${trigger['tag']}"
```
