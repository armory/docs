---
title: v1.0.58 Armory Agent Service (2023-06-09)
toc_hide: true
version: 01.00.58
date: 2023-06-09
---

Changes:
- rename the operation logging `namespace` contextual key to `operationNamespace`
- expose logging contextual key-value pairs in config file 
  ```
  logging:
    fields:
      keyOne: valueOne
      keyTwo: valueTwo
      keyN: valueN
  ```
  The following two keys could be detected automatically when a value is not provided:
  ```
  logging:
    fields:
      agentCluster:
      agentNamespace: 
  ```
  The computed value when it is not specified for the following keys will be: 
  1. `agentCluster`: Cluster name where agent is running (if `KUBERNETES_SERVICE_NAME` environment variable is set), Cluster Host where agent is running (if `KUBERNETES_SERVICE_HOST` environment variable is set), empty if any environment variable is specified 
  2. `agentNamespace`: Namespace where agent is running

Example:
Having the following configuration: 
```
logging:
  fields:
    agentCluster: test
    agentNamespace:
    keyOne: valueOne
    keyTwo: valueTwo
    keyN: valueN
```
The log will look like this:
```
INFO[0099] Operation Delete processed (status 204 No Content) in 2.03850709s  account=account1 agentCluster=test** agentId=7affa394-7ee1-456d-9528-a4339fb56051 **agentNamespace=spinnaker keyN=valueN keyOne=valueOne keyTwo=valueTwo operationId=01H2RBKP1SHP7PDXA1JEMMA6DZ operationNamespace=default operationType=Delete
```
