---
title: Connect Spinnaker to Travis CI
linkTitle: Connect to Travis
aliases:
  - /docs/spinnaker-install-admin/guides/configure-travis/
description: >
  Use Halyard to configure Spinnaker to access to your Travic CI instance.
---

## Overview of connecting Spinnaker to Travis

Before you can make use of [Travis CI](https://www.travis-ci.com/) in Spinnaker, you'll need to configure access to your Travis masters.

Configuring Travis in your Spinnaker instance with Halyard is pretty easy, but
there are a few "gotchas" to watch out for.


## Add Travis to Spinnaker

First, configure your Travis master:

```bash
hal config ci travis master add Travis --address https://api.travis-ci.org --base-url https://travis-ci.org --github-token
```

(If you're using a private Travis account, change the addresses appropriately)

For reference, you can look at the [Spinnaker docs](https://www.spinnaker.io/reference/halyard/commands/#hal-config-ci-travis-master-add)


## Enable Travis support

Next, enable Travis with Halyard:

```bash
hal config ci travis enable
```

<!-- This got carried over from the old KB article. Unlikely still needed but leaving here for posterity.
## Update `igor-local.yml` (Temporary Fix)

This is currently a bug with open source Halyard; doing the above will cause Igor to
go into a CrashLoopBackoff state.  The fix for this is to go into your
`<profile>/profiles/` directory and add (or update, if you already have one)
`igor-local.yml`.  Add this section:

```bash
artifact:
  decorator:
    enabled: true
```
-->

### Enable Travis Stages

If you want to be able to run Travis jobs as a stage in your pipeline, you'll
need to enable the stage as well:

```bash
hal config features edit --travis true
```


### Finally...

Now you should be able to `hal deploy apply` and when your services have
restarted, you should be able to trigger pipelines off Travis builds, and
see a Travis stage option in your pipelines.
