---
title: Dynamic Accounts API for Scale Agent Plugin v0.09.x
linkTitle: Plugin v0.09.x
type: swagger
description: OpenAPI (Swagger) Reference 
draft: true
---


## Usage 

The Scale Agent endpoints aren't directly accessible. If you don't have direct access to your cluster, you should [expose Clouddriver using a LoadBalancer service]({{< ref "scale-agent/install/install-agent-plugin#expose-clouddriver-as-a-loadbalancer" >}}). You can then call the API using the public `https://<clouddriver-loadbalancer-url>:<clouddriver-port>`. 

## Response codes

All requests have the following response codes:

* 200: success
* 400: the account name is not defined in Clouddriver


{{< swaggerui src="/reference/scale-agent/swagger.0.9.85.json" >}}