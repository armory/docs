---
weight: 40
title: Working with Github
aliases:
  - /spinnaker_user_guides/github/
  - /spinnaker-user-guides/github/
---

## Trigger a Pipeline with a Github commit

> Before you start, you'll need to [configure your Github repositories](/docs/spinnaker-install-admin-guides/github).
> You'll be able to configure a pipeline trigger without having configured
> your Github webhook, but the trigger won't fire until Spinnaker can receive
> those calls from Github.

To add a Github trigger to your pipeline, go to your configurations stage
and select "Add Trigger", then select "Git" from the Type dropdown menu.
Then select "github".  You can then enter your organization (ex. "armory")
and the repository name to monitor (ex. "demoapp").  Branch and Secret
are optional, although it's recommended you set Branch to whatever the name
of your production branch is (usually `master`) so you only trigger pipelines
when code is committed to the production branch.  The Branch field also
supports regular expressions, so you can limit the trigger to several branches
with common patterns or partial matches.

{{< include "regex_vs_wildcard.md" >}}

![Configure Github Trigger](/images/github-user-guide-1.gif)

## Using artifacts from Github

> Before you start, you'll need to [configure Github as an artifact source](/docs/spinnaker-install-admin-guides/github#configuring-github-as-an-artifact-source)
> You won't see the Github artifact type until this is configured.
