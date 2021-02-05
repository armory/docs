---
title: Configuring Auth for Spinnaker Using Okta SAML
linkTitle: Configuring Okta for Auth
description: >
  Configure Okta for authentication and authorization in Spinnaker.
aliases:
  - /docs/spinnaker-install-admin-guides/okta/
---

## Configure a Spinnaker application in Okta

Select Applications -> Applications from the top menu.
![Applications Screen](/images/armory-admin/artifacts/okta/okta-applications.png)

Click the green "Add Application" button.
![AddApplicationButton](/images/armory-admin/artifacts/okta/okta-addapplication.png)

Click the green "Create New App" button.
![CreateNewApp](/images/armory-admin/artifacts/okta/okta-createnewapp.png)

In the dialog "Create a New Application Integration", select the following values:

* select Platform -> Web
* select Sign on method -> SAML 2.0

Then hit the green "Create" button.

![CreateNewIntegration](/images/armory-admin/artifacts/okta/okta-createnewintegration.png)


On "Create SAML Integration" page, enter an app name and hit the green "Next" button.
![CreateNewIntegration](/images/armory-admin/artifacts/okta/okta-appname.png)

On the "Configure SAML page", configure the following settings:

* *Single sign on URL* -> Enter the URL for your Gate service, with the path /saml/SSO.
  For example, `https://oktaspinnaker.spinnaker.armory.io:8084/saml/SSO`

* *Audience URI (SP Entity ID)* -> Enter a unique entity id. For example, `io.armory.spinnaker.oktatest`

* *Name ID format* -> For example, "EmailAddress"

* *Application username* -> For example, "Email"


In the GROUP ATTRIBUTE STATEMENTS section:

* Name = memberOf, Name format = Unspecified, Filter = Regex: .*

Then, hit the green "Next" button
![SamlSettings](/images/armory-admin/artifacts/okta/okta-samlsettings.png)

On the Create SAML Integration Feedback page, select the "I'm an Okta customer adding an internal app" button, then hit the green "Finish" button.
![Feedback](/images/armory-admin/artifacts/okta/okta-feedback.png)


This takes you to the "Sign On" tab of the application you just created.

You can navigate back to this page by going to applications -> applicationName -> Sign On tab.
Click the button "View Setup Instructions".  This will display the page with configuration information
necessary to configure Spinnaker.
![ViewSetupInstructions](/images/armory-admin/artifacts/okta/okta-viewsetupinstructions.png)

Under the "Optional" section near the bottom, copy the contents of IDP metadata and save to file. For example, under `/Users/armory/.hal/saml/metadata.xml`.
![IDPmetadata](/images/armory-admin/artifacts/okta/okta-idpmetadata.png)

## Configure Spinnaker to use Okta

### 1: Create a SAML keystore file

Generate a keystore and key with some password:

```bash
KEYSTORE_PATH=/Users/armory/.hal/saml/saml.jks
keytool -genkey -v -keystore $KEYSTORE_PATH -alias saml -keyalg RSA -keysize 2048 -validity 10000
```

### 2: Configure Spinnaker to use SAML

> Note: The value you enter for `issuerId` must match the value entered in "Audience URI (SP Entity ID)" when configuring the app in Okta

{{< tabs name="configure" >}}
{{% tab name="Operator" %}}

Add the following snippet to `SpinnakerService` manifest. This references secrets stored in a Kubernetes secrets in the same namespace as Spinnaker, but secrets can be stored in any of the supported [secret engines](/docs/armory-admin/Secrets):

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

Create the kubernetes secret holding the spinnaker secrets:

```bash
kubectl -n <spinnaker namespace> create secret generic spin-secrets \
    --from-file=saml.jks \
    --from-file=metadata.xml \
    --from-literal=keystorePassword=<password-entered-in-step-1>
```

Apply the changes of `SpinnakerService` manifest:

```bash
kubectl -n <spinnaker namespace> apply -f <SpinnakerService manifest>
```

{{% /tab %}}
{{% tab name="Halyard" %}}

```bash
KEYSTORE_PATH=/Users/armory/.hal/saml/saml.jks
KEYSTORE_PASSWORD=<password-entered-in-step-1>
METADATA_PATH=/Users/armory/.hal/saml/metadata.xml
SERVICE_ADDR_URL=https://<gate-URL>
ISSUER_ID=io.armory.spinnaker.oktatest

hal config security authn saml edit \
    --keystore $KEYSTORE_PATH \
    --keystore-alias saml \
    --keystore-password $KEYSTORE_PASSWORD \
    --metadata $METADATA_PATH \
    --issuer-id $ISSUER_ID \
    --service-address-url $SERVICE_ADDR_URL

hal config security authn saml enable
hal deploy apply
```

{{% /tab %}}
{{< /tabs >}}

## Troubleshooting

Make sure the dns are correctly pointing to the load balancers of `gate-URL` and `deck-URL`.

Verify that the gate-URL is the one entered in Okta with `:8084/saml/SSO` appended to it.

Validate that the service-address-url in your configuration is the `gate-URL`.
