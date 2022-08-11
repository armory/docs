---
title: Dynamic Accounts API developer guide
description: >
   Learn about the Clouddriver HTTP REST API Dynamic Accounts endpoints for the Armory Scale Agent for Spinnaker and Kubernetes.
---

## Get Armory accounts
`GET /armory/accounts/{accountId}`

Return the list of all managed accounts, including static accounts defined in agent config files and dynamic accounts defined in Clouddriver. The resulting list is sorted by account name in ascending order.

### Request parameters
 - `page` -  The page number for paginating results, starting from 1. Defaults to 1 if omitted.
 - `limit` How many accounts to return. Defaults to 100 if omitted.

### Example response
``` json
{
  "items": [
   {example of list items needed here}
  ]
  "page": 1,
  "limit": 3,
  "total": 542
}
```
## Get an account by ID

`GET /armory/accounts/{accountId}`

Returns account details for the account ID.

### Top level response fields
 - `name`: The account name.
 - `type`: The cloud provider name (currently always kubernetes).
 - `source`: The account origin - either `clouddriver` or  `static-agent-config`.
 - `config`: The account configuration as defined in the underlying data stores.
 - `zoneId`: Identifier of the zone to which this account is pinned (optional). A missing value means that the account can be dynamically assigned to any agent available.
 - `agents`: The List of agent identifiers confirmed to handle this account, either for making deployments, watching cluster events or both.
 - `lastAssignmnentMsg`: This string represents the last message produced when assigning an account to an agent. It is used to show errors in communication, like using an invalid `kubeconfig` file. 



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
   "lastAssignmentMsg":"successfully assigned to agent agent-private-network-1-54865d798c-tdfvw for executing operations"
}
```
## Migrate Clouddriver account to Agent
`POST /armory/accounts`

Migrate an existing native clouddriver account to be managed by agents.
The `zoneId` is an optional parameter. If present, the account is pinned to agents matching the same zoneId in the Agent config. If omitted, the account can be assigned to any Agent. 

## Assign Clouddriver account to Agent
`PATCH /armory/accounts`

### Example request body

```json
{
  "name": "my-account-1",
  "zoneId": "agent-private-network-1"
}
```

Use this endpoint to activate migrated accounts on Agent. The request body for this endpoint allows the same parameters as the `POST /armory/accounts`. In most cases only the  `zoneId` is required to successfully complete the request.

### Example request body

```json
{
  "zoneId": "agent-private-network-1"
}
```

##  Delete an account
`DELETE /armory/accounts/{accountName}`

Remove an account defined in Clouddriver from an Agent.

# Response
If the request is successful a 200 response code is returned. If a 400 response is returned the account name is not defined in Clouddriver.


 {{< swaggerui src="/reference/scale-agent/dynamic-accounts/dbaas.json" >}} 