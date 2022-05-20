All network traffic is encrypted while in transit.

Encryption in transit is over HTTPS using TLS encryption. When using Armory-provided software for both the client and server, these connections are secured by TLS 1.2. Certain APIs support older TLS versions for clients that do not support 1.2.

Encryption at rest uses AES256 encryption.

The following network endpoints are used for communication into Armory CD-as-a-Service:

| DNS                       | Port | Protocol                                        | Description                                                                           |
|---------------------------|------|-------------------------------------------------|---------------------------------------------------------------------------------------|
| agent-hub.cloud.armory.io | 443  | TLS enabled gRPC over HTTP/2<br>TLS version 1.2 | Remote Network Agent Hub connection; Agent Hub routes deployment commands to RNAs and caches data received from them. Agent Hub does not require direct network access to the RNAs since they connect to Agent Hub through an encrypted, long-lived gRPC/HTTP2 connection. Agent Hub uses this connection to send deployment commands to the RNA for execution. |
| api.cloud.armory.io       | 443  | HTTP over TLS (HTTPS)<br>TLS version 1.2        | Armory REST API; Clients connect to these APIs to interact with Armory CD-as-a-Service.|
| auth.cloud.armory.io      | 443  | HTTP over TLS (HTTPS)<br>TLS version 1.2        | OIDC Service; The Open ID Connect (OIDC) service is used to authorize and authenticate machines and users. The RNAs, Armory Enterprise (Spinnaker) plugin, and other services all authenticate against this endpoint. The service provides an identity token that can be passed to the Armory API and Agent Hub.                                                                          |
| console.cloud.armory.io   | 443  | HTTP over TLS (HTTPS)<br>TLS version 1.2        | Web UI                                                                                |