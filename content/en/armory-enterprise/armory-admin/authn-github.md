---
title: Configure GitHub OAuth for Spinnaker
linkTitle: Configure GitHub OAuth
aliases:
  - /docs/spinnaker-install-admin-guides/authn-github/
description: >
  Configure GitHub and Spinnaker to use GitHub as an OAuth2 authenticator.
---

## {{% heading "prereq" %}}

* You have the ability to modify developer settings for your GitHub organization.
* You have a Spinnaker<sup>TM</sup> instance with [DNS and SSL]({{< ref "dns-and-ssl" >}}) configured.

## Configure GitHub OAuth in GitHub

Follow the instructions in GitHub's [Creating an OAuth App](https://docs.github.com/en/developers/apps/building-oauth-apps/creating-an-oauth-app) guide.

* **Homepage URL**: This is the URL of your the Gate service; for example, `https://gate.spinnaker.acme.com`.
* **Authorization callback URL**: The URL needs `login` appended to your Gate endpoint; for example,  `https://gate.spinnaker.acme.com/login`  or `https://spinnaker.acme.com/gate/login`.

## Configure GitHub OAuth in Spinnaker

Add the following snippet to your `SpinnakerService` manifest under the `spec.spinnakerConfig.config.security.authn` level:

```yaml
oauth2:
    enabled: true
    client:
      clientId: a08xxxxxxxxxxxxx93
      clientSecret: 6xxxaxxxxxxxxxxxxxxxxxxx59   # Secret Enabled Field
      scope: read:org,user:email
    provider: GITHUB
```

Review the {{< linkWithTitle "op-manifest-reference" >}} for additional configuration options.

## {{% heading "nextSteps" %}}

* [Spinnaker: OAuth](https://www.spinnaker.io/setup/security/authentication/oauth/)
* [Github: OAuth](https://help.github.com/en/articles/authorizing-oauth-apps)
* [Armory: DNS and SSL]({{< ref "dns-and-ssl" >}})
* [Spinnaker: SSL](https://www.spinnaker.io/setup/security/ssl/)
