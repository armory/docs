1. Access the [CD-as-a-Service Console](https://console.cloud.armory.io).
1. Go to the **Configuration** tab.
1. If you have more than one tenant, make sure you select the desired tenant in the User context menu.
1. In the left navigation menu, select **Access Management > Client Credentials**.
1. In the upper right corner, select **New Credential**.
1. Create a credential for your RNA. Use a descriptive name for the credential that matches what it is being used for. For example, name the credentials the same as the account name you assigned the target deployment cluster if creating a credential for an Remote Network Agent (RNA).
1. Select an RBAC role from the **Select Roles** list. You must assign an [RBAC role]({{< ref "cd-as-a-service/concepts/iam/rbac" >}}) in order for the credential to access CD-as-a-Service.

   * If the credential for is a Remote Network Agent, select **Remote Network Agent**.
   * If you plan to use the credential to deploy from a GitHub Action or similar tool, select **Deployments Full Access**.

1. Note the values for both **Client ID** and **Client Secret**. You need these values when configuring the RNA or any other service that you want to grant access to. Make sure to store the secret somewhere safe. You are not shown the value again.
