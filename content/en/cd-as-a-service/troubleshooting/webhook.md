---
title: Troubleshoot Webhooks
linktitle: Webhooks
description: >
  Solutions for issues you might encounter while using webhooks with Armory Continuous Deployment-as-a-Service.
---

## GitHub

### 401 status code

In the UI, you see a `Received non-200 status code: 401` error.

**Why this happens**

You pass invalid credentials.

**Fix**

Check that your GitHub access token is valid.

### 404 status code

```
404 Not Found: [{"message":"Not Found","documentation_url":"https://docs.github.com/rest"}]
```

**Why this happens**

This is a confusing error that occurs when you do not send authorization credentials in the header.

**Fix**

Make sure you include your GitHub token in the request header.

{{< prism lang="yaml" >}}
headers:
- key: Authorization
  value: token  {{secrets.github_personal_access_token}}
{{< /prism >}}

### Failed to fetch access token

{{< prism lang="bash" >}}
level=fatal msg="failed to fetch access token, err: no credentials set or expired. Either run armory login command to interactively login, or add clientId and clientSecret flags to specify service account credentials"
{{< /prism >}}

You may see this error when you are using Secrets in a reusable workflow.

**Why this happens**

The reusable workflow does not automatically inherit Secrets from the caller worklow.

**Fix**

You need to explicitly configure your reusable workflow to inherit Secrets. See the [GitHub docs](https://docs.github.com/en/actions/using-workflows/reusing-workflows#using-inputs-and-secrets-in-a-reusable-workflow) for details.

### Webhook process runs for a long time

**Why this happens**

The call to your action wasn't successful or your workflow didn't trigger the callback.

**Fixes**

Check your repo to see if your action is also still running.

* If the action hasn't started, the call to your action wasn't successful. The UI should display an error message with a non-200 HTTP return code when the webhook process times out. In the meantime, check your deployment file to make sure the following fields have the correct values:

   - `uriTemplate`
   - `networkMode` and optionally `agentIdentifier`
   - `event_type` in the inline body template

   If you find an error, cancel your deployment before fixing and redeploying.

* If your GitHub action workflow has completed, your workflow failed to trigger the callback to Armory CD-as-a-Service. Check GitHub's [Monitoring and troubleshooting workflows](https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows) for troubleshooting suggestions.








