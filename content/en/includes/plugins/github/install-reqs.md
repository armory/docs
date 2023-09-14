* You have read the GitHub API Plugin [overview]({{< ref "plugins/github-api/_index.md" >}}).
* You are familiar with [GitHub Apps](https://docs.github.com/en/apps/overview).
* You need to create and install a GitHub App that interacts with the GitHub API plugin. 

  1. Create a GitHub App. Follow the instructions in GitHub's [Registering a GitHub App](https://docs.github.com/en/apps/creating-github-apps/registering-a-github-app/registering-a-github-app) guide. 
  
     * Provide values for **GitHub App name**. **Homepage URL**, and **Repository permissions**. You _do not_ need to fill out the **Identifying and authorizing users**, **Post installation**, or **Webhook** sections.
     * Your GitHub App should have the following **Repository permissions**:

       * **Actions**: `Read and write`
       * **Contents**: `Read and write`
       * **Deployments**: `Read and write`
       * **Metadata**: `Read-only`

   1. Install the GitHub App you created either in a specific repo or organization-wide. Follow the instructions in GitHub's [Installing your own GitHub App](https://docs.github.com/en/apps/using-github-apps/installing-your-own-github-app) guide.
