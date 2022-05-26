1. Access the [CD-as-a-Service Console](https://console.cloud.armory.io).
1. Go to the **Configuration** tab.
1. If you have more than one tenant, make sure you select the desired tenant in the User context menu.
1. In the left navigation menu, select **Access Management > Client Credentials**.
1. In the upper right corner, select **New Credential**.
1. Create a credential for your RNAs. Use a descriptive name for the credential that matches what it is being used for. For example, name the credentials the same as the account name you assigned the target deployment cluster if creating a credential for an Remote Network Agent (RNA).
1. Set the permission scope to a preconfigured scope group or manually assign permissions. If the credential is for a RNA, select **Remote Network Agent** from the preconfigured scope group. The group assigns the minimum set of required permissions for a RNA to work:

   - `write:infra:data`
   - `get:infra:op`
   - `connect:agentHub`

   _Removing a preconfigured scope group does not remove the permissions that a preconfigured scope group assigns. You must remove the permissions manually._

1. Note both the `Client ID` and `Client Secret`. You need these values when configuring the RNA or any other service that you want to grant access to. Make sure to store the secret somewhere safe. You are not shown the value again.
