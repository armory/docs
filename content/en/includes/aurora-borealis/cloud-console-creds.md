1. Log in to the Armory Cloud Console: https://console.cloud.armory.io/.
2. If you have more than one environment, ensure the proper env is selected in the user context menu:

   {{< figure src="/images/deploy-engine/cloud-env-context.png" alt="The upper right section of the window shows what environment you are currently in." >}}

3. In the left navigation menu, select **Access Management > Client Credentials**.
4. In the upper right corner, select **New Credential**.
5. Create a credential for your RNAs. Use a descriptive name for the credential, such as `Armory K8s Agent`
6. Set the permission scope to the following:

- `write:infra:data`
- `get:infra:op`

> This is the minimum set of required permissions for a RNA.

5. Note both the `Client ID` and `Client Secret`. You need these values when configuring the Agent. Make sure to store the secret somewhere safe. You are not shown the value again.