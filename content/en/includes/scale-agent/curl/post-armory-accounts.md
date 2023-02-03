  ```bash
   curl --request POST \
   --url http://clouddriver:7002/armory/accounts \
   --header 'Content-Type: application/json' \
   --data '[
   {
    "name":   "account-01"
   },
   {
    "name":   "account-02",
    "zoneId": "agent-1_namespace1",
    "kubeconfigFile": "encryptedFile:k8s!n:kubeconfig!k:config!ns:spinnaker"
   }
   ]'
   ```