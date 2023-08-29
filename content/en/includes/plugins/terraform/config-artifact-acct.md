The Terraform Integration uses the following artifact accounts:
  * **Git Repo** - To fetch the repo housing your main Terraform files.
  * **GitHub, BitBucket or HTTP** - *Optional*. To fetch single files such as var-files or backend config files.


**Configure the Git Repo artifact**

Spinnaker uses the Git Repo Artifact Provider to download the repo containing your main Terraform templates.

Edit your configuration to add the following:

```yaml
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        artifacts:
          gitRepo:
            enabled: true
            accounts:
            - name: gitrepo
              token: <your-personal-access-token> #  personal access token
```

For more configuration options, see [Configure a Git Repo Artifact Account](https://spinnaker.io/setup/artifacts/gitrepo/).