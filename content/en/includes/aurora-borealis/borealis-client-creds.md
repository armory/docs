1. Log in to the Armory Cloud Console: https://console.cloud.armory.io/.
2. If you have more than one environment, ensure the proper environment is selected in the user context menu:

   {{< figure src="/images/deploy-engine/cloud-env-context.png" alt="The upper right section of the window shows what environment you are currently in." >}}

3. In the left navigation menu, select **Access Management > Client Credentials**.
4. In the upper right corner, select **New Credential**.
5. Create a credential for your RNAs. Use a descriptive name for the credential that matches what it is being used for. For example, name the credentials the same as the account name you assigned the target deployment cluster if creating a credential for an Remote Network Agent (RNA).
6. Set the permission scope to a pre-configured scope group or manually assign permissions. If the credential is for a RNA, select **Remote Network Agent** from the pre-configured scope group. The group assigns the minimum set of required permissions for a RNA to work:

   - `write:infra:data`
   - `get:infra:op`
   - `connect:agentHub`

  > Removing a pre-configured scope group does not unassign the permissions that a pre-configured scope group assigns. You must remove the permissions manually.

7. Note both the `Client ID` and `Client Secret`. You need these values when configuring the RNA or any other service that you want to grant access to. Make sure to store the secret somewhere safe. You are not shown the value again.
