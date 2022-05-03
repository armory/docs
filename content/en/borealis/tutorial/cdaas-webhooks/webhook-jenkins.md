---
title: Jenkins Webhook-Based Approvals Tutorial
linktitle: Jenkins
exclude_search: true
draft: true
description: >
  Tutorial
---

## Objectives



## {{% heading "prereq" %}}

- You have read the webhook approval [introductory page]({{< ref "cdaas-webhooks" >}}).





{{< prism lang="yaml" line-numbers="true" line="3" >}}
webhooks:
  - name: jenkins-integration
    method: POST
    uriTemplate: https://myprivate.jenkins:9000/buildByToken/buildWithParameters?token=${secrets.potato-facts-jenkins-secret}&job=PotatoIntegrationTestJob&replicaSetName=${replicaSetName}&callbackUri=${callbackUri}
    networkMode: remoteNetworkAgent // direct or rna - `nil` by default will fall back to the configured account
    agentIdentifier: jenkins-rna //can override the test-env.account with an agent name or account name that has an rna configured
    headers:
      - key: Authorization
        value: Basic ${potato-facts-jenkins-auth}
{{< /prism >}}

not that the URI template has a token, webhook parms as placeholders, and the callback


Jenkins uses query parameters via a buildWithParameters API endpoint. You can pass additional, custom, parameters.

```
https://jenkins.example.com/buildByToken/buildWithParameters?token=Secure-Token&job=TestJob&replicaSetName=spring-potato
```
The token param above is specific to the job, but servers may also require authenticated requests. Jenkins uses Basic Auth and allows you to create username:api-token  for machine use, much like GitHub's personal access tokens.
https://www.jenkins.io/doc/book/system-administration/authenticating-scripted-clients/

Jenkins users may also want to use crumbs however, this requires a process where we would take user/pass and request a token to use in executing the job build request. We will not support crumbs at this time because it would require custom Jenkins logic.

Callback

Callback will need to be handled by a custom script or http-request job.