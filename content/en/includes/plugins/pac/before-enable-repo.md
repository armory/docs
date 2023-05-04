Before configuring your repos, ensure you have the following:

1. A personal access token that has read access to the repo where you store your `dinghyfile` and the repo where you store `module` files. You should create a  Kubernetes [Secret]({{< ref "continuous-deployment/armory-admin/Secrets" >}}) for your personal access token so you don't store the token in plain text in your config file.
1. The organization where the app repos and templates reside; for example, if your repo is `armory-io/dinghy-templates`, your `template-org` is `armory-io`.
1. The name of the repo containing your modules; for example, if your repo is `armory-io/dinghy-templates`, your `template-repo` is `dinghy-templates`.