The following table lists the Armory and Spinnaker services, their type (Java or Golang), and which certificates they need:

| Service | Type | Server | Client |
|------|---|--|--|
| Clouddriver | Java  | Yes | Yes |
| Deck | N/A | - | - |
| Dinghy* | Golang | Yes | Yes |
| Echo | Java | Yes | Yes |
| Fiat | Java | Yes | Yes |
| Front50 | Java | Yes | Yes |
| Gate | Java | Maybe | Yes |
| Kayenta | Java | Yes | Yes |
| Igor | Java | Yes | Yes |
| Orca | Java | Yes | Yes |
| Rosco | Java | Yes | Yes |
| Terraformer* | Golang | Yes | Yes |

* Dinghy is the service for Pipelines-as-Code.
* Terraformer is the service for the Armory Terraform Integration.

**Note**: Gate may be handled differently if you already [terminating SSL at Gate]({{< ref "dns-and-ssl" >}}). If not, make sure the load balancer and ingress you are using supports self-signed certificates.

In the following sections, you need to have the following information available:

- `ca.pem` (all Golang servers): the CA certificate in PEM format
- `[service].crt` (each Golang server): the certificate and (optionally) the private key of the Golang server in PEM format
- `[service].key` (each Golang server): the private key of the Golang server if not bundled with the certificate you're using
- `[GOSERVICE]_KEY_PASS` (each Golang server): the password to the private key of the server
- `truststore.p12` (all Java clients): a PKCS12 truststore with CA certificate imported
- `TRUSTSTORE_PASS` (all Java clients): the password to the truststore you're using
- `[service].p12` (each Java server): a PKCS12 keystore containing the certificate and private key of the server
- `[SERVICE]_KEY_PASS` (each Java server): the password to the keystore you're using

The server certificate will serve as its client certificate to other services. You can generate different certificates and use them in `ok-http-client.key-store*` (Java) and `http.key*` (Golang).

To learn how to generate these files, see the {{< linkWithTitle "generating-certificates">}} guide.