```bash
curl --request PATCH \
  --url http://localhost:7002/armory/accounts \
  --header 'Content-Type: application/json' \
  --data '[
 {
  "name":  "account-01",
  "state": "ACTIVE"
 },
 {
  "name":   "account-02",
  "state": "ACTIVE",
  "zoneId": "agent-1_namespace1",
  "kubeconfigFile": "encryptedFile:k8s!n:kubeconfig!k:config!ns:spinnaker"
 }
]'
```