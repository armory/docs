---
title: Configure Auth for Spinnaker Using Okta SAML
linkTitle: Configure Okta for Auth
description: >
  Configure Okta for authentication and authorization in Spinnaker.
aliases:
  - /docs/spinnaker-install-admin-guides/okta/
---

## Configure a Spinnaker application in Okta

Select **Applications** > **Applications** from the top menu.
![Applications Screen](/images/armory-admin/artifacts/okta/okta-applications.png)

Click the **Add Application** button.
![AddApplicationButton](/images/armory-admin/artifacts/okta/okta-addapplication.png)

Click the **Create New App** button.
![CreateNewApp](/images/armory-admin/artifacts/okta/okta-createnewapp.png)

In the dialog **Create a New Application Integration**, select the following values:

* **Platform** > Web
* **Sign on method** > SAML 2.0

Then click the **Create** button.

![CreateNewIntegration](/images/armory-admin/artifacts/okta/okta-createnewintegration.png)


On the **Create SAML Integration** screen, enter an app name and click the **Next** button.
![CreateNewIntegration](/images/armory-admin/artifacts/okta/okta-appname.png)

On the **Configure SAML** screen, configure the following settings:

* **Single sign on URL**: Enter the URL for your Gate service, with the path `/saml/SSO`. For example, `https://oktaspinnaker.spinnaker.armory.io:8084/saml/SSO`

* **Audience URI (SP Entity ID)**: Enter a unique entity id. For example, `io.armory.spinnaker.oktatest`

* **Name ID format**: For example, "EmailAddress"

* **Application username**: For example, "Email"


In the **GROUP ATTRIBUTE STATEMENTS** section:

* **Name** = memberOf, **Name format** = Unspecified, **Filter** = Regex: .*

Then, click the **Next** button.
![SamlSettings](/images/armory-admin/artifacts/okta/okta-samlsettings.png)

On the **Create SAML Integration** screen, select **I'm an Okta customer adding an internal app** and then click the **Finish** button.
![Feedback](/images/armory-admin/artifacts/okta/okta-feedback.png)


This takes you to the **Sign On** screen of the application you just created.

Click the **View Setup Instructions** button.  This displays the page with  information necessary to configure Spinnaker.
![ViewSetupInstructions](/images/armory-admin/artifacts/okta/okta-viewsetupinstructions.png)

In the **Optional** section, copy the contents of IDP metadata and save to file. For example, under `/Users/armory/.hal/saml/metadata.xml`.
![IDPmetadata](/images/armory-admin/artifacts/okta/okta-idpmetadata.png)

## Configure Spinnaker to use Okta

### 1: Create a SAML keystore file

>Make sure the Java version used to generate the keystore is the same version used to run Armory Enterprise or Spinnaker.

Generate a keystore and key:

```bash
KEYSTORE_PATH=/Users/armory/.hal/saml/saml.jks
keytool -genkey -v -keystore KEYSTORE_PATH -alias saml -keyalg RSA -keysize 2048 -validity 10000 -storetype JKS
```

### 2: Configure Spinnaker to use SAML

>The value you enter for `issuerId` must match the value entered in **Audience URI (SP Entity ID)** when configuring the app in Okta

Add the following snippet to `SpinnakerService` manifest. This references secrets stored in a Kubernetes secrets in the same namespace as Spinnaker, but secrets can be stored in any of the supported [secret engines]({{< ref "continuous-deployment/armory-admin/secrets" >}}):

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:  
    config:
      security:
        authn:
          saml:
            enabled: true
            keyStore: encryptedFile:k8s!n:spin-secrets!k:saml.jks
            keyStoreAliasName: saml
            keyStorePassword: encrypted:k8s!n:spin-secrets!k:keystorePassword
            metadataLocal: encryptedFile:k8s!n:spin-secrets!k:metadata.xml
            issuerId: io.armory.spinnaker.oktatest # The identity of the Spinnaker application registered with the SAML provider.
            serviceAddress: https://<gate-URL>     # The address of the Gate server that will be accesible by the SAML identity provider. This should be the full URL, including port, e.g. https://gate.org.com:8084/. If deployed behind a load balancer, this would be the laod balancer's address.
```

Create the Kubernetes secret holding the Spinnaker secrets:

```bash
kubectl -n <spinnaker namespace> create secret generic spin-secrets \
    --from-file=saml.jks \
    --from-file=metadata.xml \
    --from-literal=keystorePassword=<password-entered-in-step-1>
```

Apply your changes to the `SpinnakerService` manifest:

```bash
kubectl -n <spinnaker namespace> apply -f <SpinnakerService manifest>
```

## Troubleshooting

Make sure the DNS is correctly pointing to the load balancers of `gate-URL` and `deck-URL`.

Verify that the `gate-URL` is the one entered in Okta with `:8084/saml/SSO` appended to it.

Validate that the `service-address-url` in your configuration is the `gate-URL`.
