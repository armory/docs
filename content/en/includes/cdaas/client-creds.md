1. Log in to the CD-as-a-Service Console: https://console.cloud.armory.io/.
2. Go to the **Configuration** tab.
3. If you have more than one environment, ensure the proper environment is selected in the user context menu:

   {{< figure src="/images/deploy-engine/cloud-env-context.png" alt="The upper right section of the window shows what environment you are currently in." >}}

4. In the left navigation menu, select **Access Management > Client Credentials**.
5. In the upper right corner, select **New Credential**.
6. Create a credential for your RNAs. Use a descriptive name for the credential that matches what it is being used for. For example, name the credentials the same as the account name you assigned the target deployment cluster if creating a credential for an Remote Network Agent (RNA).
7. Set the permission scope to a pre-configured scope group or manually assign permissions. If the credential is for a RNA, select **Remote Network Agent** from the pre-configured scope group. The group assigns the minimum set of required permissions for a RNA to work:

   - `write:infra:data`
   - `get:infra:op`
   - `connect:agentHub`

   _Removing a pre-configured scope group does not unassign the permissions that a pre-configured scope group assigns. You must remove the permissions manually._

8. Note both the `Client ID` and `Client Secret`. You need these values when configuring the RNA or any other service that you want to grant access to. Make sure to store the secret somewhere safe. You are not shown the value again.
