
* `version`: Replace `<version>` with the plugin version compatible with your Spinnaker version.
* `accounts`:  Configure the GitHub location(s) where you installed the GitHub App you created. The configuration differs depending on whether you installed the GitHub App organization-wide or with access to individual repositories.

{{< tabpane text=true right=true >}}
{{% tab header="**Account Config**:" disabled=true /%}}
{{% tab header="Individual Repo" %}}

```yaml
- name: <name>
  organization:  <github_organization>
  repository: <github_repository>
  defaultBranch: <default_github_branch>
  githubAppId: <github_app_id>
  githubAppPrivateKey: <your_github_private_key>
```

All fields are required.

* `name`:  Unique name; this name appears in the GitHub API stages' `GitHub Account` select list.
* `organization`: GitHub organization that you installed the GitHub App in
* `repository`: The GitHub repository to access
* `defaultBranch`: Default repository branch; for example, main or master
* `githubAppId`: The GitHub App's **App ID**
* `githubAppPrivateKey`: The GitHub App's private key; this field supports encrypted field references; see [Work with Secrets in Spinnaker]({{< ref "continuous-deployment/armory-admin/secrets" >}}) for details.

{{% /tab %}}
{{% tab header="All Repos in Org" %}}

```yaml
- name: <name>
  organization:  <github_organization>
  orgWide: true
  defaultBranch: <default_github_branch>
  githubAppId: <github_app_id>
  githubAppPrivateKey: <your_github_private_key>
```

All fields are required.

* `name`:  Unique name; this name appears in the GitHub API stages' `GitHub Account` select list.
* `organization`: GitHub organization that you installed the GitHub App in
* `orgWide`: `true`
* `defaultBranch`: Default repository branch; for example, main or master
* `githubAppId`: The GitHub App's **App ID**
* `githubAppPrivateKey`: The GitHub App's private key; this field supports encrypted field references; see [Work with Secrets in Spinnaker]({{< ref "continuous-deployment/armory-admin/secrets" >}}) for details.

{{% /tab %}}
{{< /tabpane >}}