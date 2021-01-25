---
title: Configuring GitHub OAuth for Spinnaker
linkTitle: Configuring GitHub OAuth
aliases:
  - /docs/spinnaker-install-admin-guides/authn-github/
description: >
  Configure GitHub and Spinnaker to use GitHub as an OAuth2 authenticator.
---

## Requirements for configuring GitHub OAuth

* Ability to modify developer settings for your GitHub organization
* Access to Halyard
* A Spinnaker<sup>TM</sup> deployment with [DNS and SSL]({{< ref "dns-and-ssl" >}}) configured

## Configuring GitHub OAuth in GitHub

1. Login to GitHub and go to Settings > Developer Settings > OAuth Apps > New OAuth App
2. Note the Client ID / Client Secret
3. Homepage URL: This would be the URL of your Spinnaker service e.g. `https://spinnaker.acme.com`
4. Authorization callback URL: This is going to match your `--pre-established-redirect-uri` in halyard and the URL needs `login` appended to your gate endpoint e.g. `https://gate.spinnaker.acme.com/login`  or `https://spinnaker.acme.com/gate/login`

## Configuring GitHub OAuth in Spinnaker

{{< tabs name="config" >}}
{{% tab name="Operator" %}}

Add the following snippet to your `SpinnakerService` manifest under the `spec.spinnakerConfig.config.security.authn` level:

```yaml
oauth2:
    enabled: true
    client:
      clientId: a08xxxxxxxxxxxxx93
      clientSecret: 6xxxaxxxxxxxxxxxxxxxxxxx59   # Secret Enabled Field
      scope: read:org,user:email
      preEstablishedRedirectUri: https://gate.spinnaker.acme.com/login
    provider: github
```

For additional configuration options review the [Spinnaker Operator Reference]({{< ref "operator-reference" >}})

{{% /tab %}}
{{% tab name="Halyard" %}}

Run the following commands in Halyard with your Client ID and Client Secret.

```bash
CLIENT_ID=a08xxxxxxxxxxxxx93
CLIENT_SECRET=6xxxaxxxxxxxxxxxxxxxxxxx59
PROVIDER=github

hal config security authn oauth2 edit \
  --client-id $CLIENT_ID \
  --client-secret $CLIENT_SECRET \
  --provider $PROVIDER \
  --scope read:org,user:email \
  --pre-established-redirect-uri "https://gate.spinnaker.acme.com/login"

hal config security authn oauth2 enable
```

{{% /tab %}}
{{< /tabs >}}

## Additional OAuth resources

* [Spinnaker: OAuth](https://www.spinnaker.io/setup/security/authentication/oauth/)
* [Github: OAuth](https://help.github.com/en/articles/authorizing-oauth-apps)
* [Armory: DNS and SSL]({{< ref "dns-and-ssl" >}})
* [Spinnaker: SSL](https://www.spinnaker.io/setup/security/ssl/)
