---
title: Add New Context Variables at Deploy Time
linktitle: Add Context Variables at Deploy Time
description: >
  Add new context variables from the command line or in your GitHub Action. These variables are injected into your canary analysis and webhook triggers.
exclude_search: true
---

## How to add new context variables

You can add new context variables at deployment time by using the `--add-context` argument on the command line or from within your [Armory CD-as-a-Service GitHub Action]({{< ref "gh-action" >}}). Armory CD-as-a-Service adds the new context variables to webhook triggers and canary analysis steps in any deployment constraint.

The value of the `--add-context` argument is a comma-delimited list of key=value pairs.

For this example, you want to add the following new context variables:

| Name        | Value      |
| ----------- | ---------- |
| smokeTest   | true       |
| environment | prod       |
| changeBy    | jane-smith |

<br>
Your command line looks like this:

{{< prism lang="bash" line-numbers="true" >}}
armory deploy start -f deploy.yml --add-context=smokeTest=true,environment=prod,changeBy=jane-doe
{{< /prism >}}
<br>
In your GitHub Action, you add an `addContext` key in your `Deployment` step.

{{< prism lang="yaml" line-numbers="true" line="22" >}}
name: Deploy my latest version

on:
  push:
    branches:
      - main  

jobs:
  build:
    name: deploy from main
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Deployment
        uses: armory/cli-deploy-action@main
        with:
          clientId: "${{ secrets.CDAAS_CLIENT_ID }}"
          clientSecret:  "${{ secrets.CDAAS_CLIENT_SECRET }}"
          path-to-file: "/deploy.yml"
          addContext: "smokeTest=true,environment=prod,changeBy=jane-doe"
          applicationName: "potato-facts"
{{< /prism >}}

## Known issues

Context variables are not added in the following situations:

* An `analysis` step when used in an after deployment constraint
* A step in a blue/green deployment strategy

