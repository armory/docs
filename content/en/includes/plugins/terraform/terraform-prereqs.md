**Terraform Integration requirements**

* Basic auth credentials for the Git repository where your store your Terraform scripts. The Terraform Integration plugin needs access to credentials to download directories that house your Terraform templates.
  * You can configure your Git repo with any of the following:
    * A Personal Access Token (potentially associated with a service account). 
    * SSH protocol in the form of an SSH key or an SSH key file
    * Basic auth in the form of a user and password, or a user-password file
* A source for Terraform Input Variable files (`tfvar`) or a backend config. You must have a separate artifact provider that can pull your `tfvar` file(s). The Terraform Integration plugin supports the following artifact providers for `tfvar` files and backend configs:
  * GitHub
  * BitBucket
  * HTTP artifact
* A dedicated external Redis instance
  * Armory requires configuring a dedicated external Redis instance for production usage of the Terraform Integration plugin. This is to ensure that you do not encounter scaling or stability issues in production.  