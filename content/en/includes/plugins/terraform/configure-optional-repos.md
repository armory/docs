>This step is optional.

{{< tabpane text=true right=true >}}
{{% tab header="**Configure Optional Repos**:" disabled=true /%}}

{{% tab header="GitHub" %}}

These *optional* steps describe how to configure GitHub as an artifact provider for the Terraform Integration. 

Spinnaker uses the Github Artifact Provider to download any referenced `tfvar` files.

Configure your GitHub artifact:

```yaml
spec:
  spinnakerConfig:
    config:
      artifacts:
        github:
          accounts:
          - name: <github-for-terraform> 
            token: <your-github-personal-access-token>
          enabled: true
```

* `name`: the name for this account; replace `github-for-terraform` with a unique identifier for the artifact account. 
* `token`:  GitHub personal access token; this field supports "encrypted" field references.

{{% /tab %}}

{{% tab header="Bitbucket" %}}
Spinnaker uses the BitBucket Artifact Provider to download any referenced `tfvar` files, so it must be configured with the BitBucket token to pull these files.

```yaml
spec:
  spinnakerConfig:
    config:
      artifacts:
        bitbucket:
          enabled: true
          accounts:
          - name: <bitbucket-for-terraform>
            username: <your-bitbucket-username>
            password: <your-bitbucket-password>
```

* `name`: the name for this account; replace `<bitbucket-for-terraform>` with a unique identifier for the artifact account.
* `username`: Your Bitbucket username.
* `password`: Your Bitbucket password; this field supports "encrypted" field references.


{{% /tab %}}

{{< /tabpane >}}