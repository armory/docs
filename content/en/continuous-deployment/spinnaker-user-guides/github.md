---
title: Use GitHub in Spinnaker Pipelines
linkTitle: Use GitHub
aliases:
  - /spinnaker_user_guides/github/
description: >
  Add a GitHub trigger to your Spinnaker pipeline.
---

## Trigger a Pipeline with a GitHub commit

> Before you start, you'll need to [configure your GitHub repositories]({{< ref "artifacts-github-use" >}}).
> You'll be able to configure a pipeline trigger without having configured
> your GitHub webhook, but the trigger won't fire until Spinnaker can receive
> those calls from GitHub.

To add a GitHub trigger to your pipeline, go to your configurations stage
and select "Add Trigger", then select "Git" from the Type dropdown menu.
Then select "github".  You can then enter your organization (ex. "armory")
and the repository name to monitor (ex. "demoapp").  Branch and Secret
are optional, although it's recommended you set Branch to whatever the name
of your production branch is (usually `master`) so you only trigger pipelines
when code is committed to the production branch.  The Branch field also
supports regular expressions, so you can limit the trigger to several branches
with common patterns or partial matches.

{{< include "regex_vs_wildcard.md" >}}

{{< figure src="/images/github-user-guide-1.gif" >}}