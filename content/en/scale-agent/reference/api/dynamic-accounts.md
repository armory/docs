---
title: Armory Scale Agent Dynamic Accounts API
linkTitle: Dynamic Accounts API
description: >
  The Armory Scale Agent Clouddriver HTTP REST API Dynamic Accounts endpoints for Spinnaker and Kubernetes.
---

## Get Armory accounts
`GET /armory/accounts`

Return a list of all managed accounts, including static accounts defined in Agent config files, and dynamic accounts defined in Clouddriver. The returned list is sorted by account name in ascending order.

### Request parameters
 - `page` -  The page number for paginating results, starting from 1. This parameter defaults to 1 if omitted.
 - `limit` How many accounts to return. Defaults to 100 if omitted.

### Example response
``` json
{
   "items":[
      
   ],
   "page":1,
   "limit":3,
   "total":542
}
```
## Get an account by ID
`GET /armory/accounts/{accountId}`

Return account details based on the `accountId`.

### Top level response fields
 - `name`: The account name.
 - `type`: The cloud provider name (currently always kubernetes).
 - `source`: The account origin - either `clouddriver` or  `static-agent-config`.
 - `config`: The account configuration as defined in the underlying data stores.
 - `zoneId`: Identifier of the zone to which this account is pinned (optional). A missing value means that the account can be dynamically assigned to any available Agent.
 - `agents`: The List of Agent identifiers confirmed to handle the account, either for making deployments, watching cluster events, or both.
 - `lastAssignmnentMsg`: This string represents the last message produced when assigning an account to an Agent. It is used to reveal communication errors, for example using an invalid `kubeconfig` file.

### Example response
``` json
{
   "name":"my-account-1",
   "type":"kubernetes",
   "source":"clouddriver",
   "config":{

   },
   "zoneId":"agent-private-network-1",
   "agents":{
      {
         "agentId":"agent-private-network-1-54865d798c-cpqgm",
         "caching":true
      },
      {
         "agentId":"agent-private-network-1-54865d798c-tdfvw",
         "caching":false
      }
   },
   "lastAssignmentMsg":"successfully assigned to Agent agent-private-network-1-54865d798c-tdfvw for executing operations"
}
```
## Migrate Clouddriver account to Agent
`POST /armory/accounts`

Provide the account number for an existing native Clouddriver account to be later migrated to an Agent. The `zoneId` is an optional parameter. If present, the account is pinned to agents matching the Agent configuration or its computed value: `deploymentName_namespace`. If omitted, the account is assigned to any available Agent pod. same zoneId ".

### Request parameters
- `name`: the name of the account matching the account in clouddriver accounts.
- `zoneId` (optional): the name of the zoneId for the targeted Agent `replicaset`, it is by default `deploymentName_namespace,`
- `kubeConfigFile` (optional): a secret token for a `kubeconfig` path or file, it supports `encrypted/encryptedFile`.

#### Example request body
```json
[
   {
      "name":"account-01"
   },
   {
      "name":"account-02",
      "zoneId":"agent-1_namespace1",
      "kubeconfigFile":"encryptedFile:k8s!n:kubeconfig!k:config!ns:spinnaker"
   }
]
```

#### Response
If the request is successful a 200 response code is returned. If a 400 response is returned the account name is not defined in Clouddriver.

## Assign Clouddriver account to Agent
`PATCH /armory/accounts`

Use this endpoint to activate migrated accounts on an Agent. The request body for this endpoint provides the same parameters as the `POST /armory/accounts`. In most cases, only the  `zoneId` is required to successfully complete the request.

### Prerequisites
- The account must be in an `INACTIVE` or `FAILED` state.
- An active connection with Agent.

### Request parameters
- `name`: the name of the account matching the account in clouddriver accounts.
- `zoneId` (optional): the name of the zoneId for the targeted Agent `replicaset`, it is by default `deploymentName_namespace,`
- `kubeConfigFile` (optional): a secret token for a `kubeconfig` path or file, it supports `encrypted/encryptedFile`.

> If the `zoneId` is supplied in a prior `POST` request it is not necessary to include it in this call. In this scenario the request tells Clouddriver to send the account to all agents. Keep in mind that if the targeted k8s cluster in `kubeconfig` is unreachable by one Agent leaving out the `zoneId` may unnecessary stress on the services infrastructure.

> The `kubeconfigFile` is optional only if supplied in the previous `POST` or if the native account `kubeconfig` works for the targeted Agent. In most cases it is a best practice to include this parameter with a valid value.

#### Example request body

```json
[
   {
      "name":"account-01",
      "state":"ACTIVE"
   },
   {
      "name":"account-02",
      "state":"ACTIVE",
      "zoneId":"agent-1_namespace1",
      "kubeconfigFile":"encryptedFile:k8s!n:kubeconfig!k:config!ns:spinnaker"
   }
]
```

#### Response
If the request is successful a 200 response code is returned. If a 400 response is returned the account name is not defined in Clouddriver.

## Delete an account
`DELETE /armory/accounts/{accountName}`

Remove a Clouddriver migrated account from an Agent.

# Response
If the request is successful a 200 response code is returned. If a 400 response is returned the account name is not defined in Clouddriver.

