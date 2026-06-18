---
title: Horizontal Scaling Architecture and Features
linkTitle: Horizontal Scaling
description: >
  Learn how the Horizontal Scaling feature helps by distributing operations across Armory Scale Agent replicas in your Armory Continuous Deployment or Spinnaker environment.
aliases:
  - /scale-agent/tasks/horizontal-scaling/
---

## Overview of Horizontal Scaling

Rather than sending operations to the first Scale Agent instance that could handle it, horizontal Scaling provides a way to improve operations by distributing them across all the Scale Agent replicas that could handle it.

### How to enable and use Horizontal Scaling

First, familiarize yourself with the architecture and features in this guide. Then you can:

1. {{< linkWithTitle "plugins/scale-agent/tasks/horizontal-scaling/operations-enable.md" >}}

## Horizontal Scaling glossary

- **K8s Operation**: an abstraction of a K8s operation; Get, List, Add, Delete, Patch etc.
- **Dynamic account Operation**: an abstraction of a dynamic account operation; Add or Unregister accounts
- **Endpoint**: the URL segment after the Clouddriver root
- **Request**: an instruction that isn’t fulfilled immediately and can have different outcomes; a request can be done through HTTP by the admin or internally by one of the services.

## Architecture

First is important to understand the main difference between K8s operations and Dynamic account operations.

|K8s                                                                                               |Dynamic account                                                    |
|--------------------------------------------------------------------------------------------------|-------------------------------------------------------------------|
|Are handled by a single Scale Agent Instance                                                      |Could be handled by more than one Scale Agent Instance             |
|Are processed on every polling cycle; configured by `kubesvc.operations.database.scan` properties |Are processed on demand                                            |
|Assigning on `clouddriver.kubesvc_operation_single_assign` table                                  |Assigning on `clouddriver.kubesvc_operation_multiple_assign` table |


The Scale Agent stores K8s and Dynamic Account operations data in dedicated tables that act like a queue:
- `clouddriver.kubesvc_operation`: Has the information of new received operations
- `clouddriver.kubesvc_operation_single_assign`: Has the information of K8s operations that could be assigned just to a single Scale Agent Instance
- `clouddriver.kubesvc_operation_multiple_assign`: Has the information of dynamic account operations that could be assigned to multiple Scale Agent Instances 
- `clouddriver.kubesvc_operation_history`: Has the information of K8s and dynamic account operations responses

### K8s Operations

The Scale Agent Plugin creates a job per Scale Agent Instance registration, this job is in charge of:
1. Fetching pending K8s operations from `clouddriver.kubesvc_operation` table
2. Assigning pending K8s operations on clouddriver.kubesvc_operation_single_assign table
3. Fetch assigned K8s operations from `clouddriver.kubesvc_operation_single_assign` table and send it to Scale Agent 

Some important thing to know about it, is that when getting a bad operation response and there is still time to do a retry (based on `kubesvc.cache.operationWaitMs` property), the Scale Agent Plugin does the following:
The Scale Agent Plugin does: 
1. Stored the response on `clouddriver.kubesvc_operation_history` table
2. Unassigns the operation from `clouddriver.kubesvc_operation_single_assign` table, so that another or the same Scale Agent instance can take it again

```mermaid
C4Deployment
    title Scale Agent Horizontal Scaling Registration Jobs
    Boundary(spin, "Armory Continuous Deployment or Spinnaker", "Instance", $borderColor="#0FC2C0") {
        Boundary(cd, "Clouddriver", "Service", $borderColor="orange") {
            System(sap, "Scale Agent Plugin<br/>", "For each registration creates a job to assign and send<br/>every N milliseconds the maximum number of K8s operations.<br/><br/>N = kubesvc.operations.database.scan.initialDelay | maxDelay<br/>maximum number = kubesvc.operations.database.scan.batchSize")
            System(saj0, "Scale Agent Job 0", "")
            System(saj1, "Scale Agent Job 1", "")
            System(saj2, "Scale Agent Job 2", "")
            UpdateElementStyle(saj0, $bgColor="#04AA6D", $borderColor="none")
            UpdateElementStyle(saj1, $bgColor="#f44336", $borderColor="none")
            UpdateElementStyle(saj2, $bgColor="#555555", $borderColor="none")
        }
        Boundary(sa, "Armory Scale Agent", "Service", $borderColor="purple") {
            System(sar0, "Replica 0", "")
            System(sar1, "Replica 1", "")
            System(sar2, "Replica 2", "")
            UpdateElementStyle(sar0, $bgColor="#04AA6D", $borderColor="none")
            UpdateElementStyle(sar1, $bgColor="#f44336", $borderColor="none")
            UpdateElementStyle(sar2, $bgColor="#555555", $borderColor="none")
        }
        Rel(sar0, sap, "Registration", "")
        UpdateRelStyle(sar0, sap, $textColor="black", $lineColor="#04AA6D")
        Rel(sar1, sap, "Registration", "")
        UpdateRelStyle(sar1, sap, $textColor="black", $lineColor="#f44336")
        Rel(sar2, sap, "Registration", "")
        UpdateRelStyle(sar2, sap, $textColor="black", $lineColor="#555555")
        Rel(sap, saj0, "Create")
        UpdateRelStyle(sap, saj0, $textColor="black", $lineColor="#04AA6D")
        Rel(sap, saj1, "Create")
        UpdateRelStyle(sap, saj1, $textColor="black", $lineColor="#f44336", $offsetX="-30", $offsetY="55")
        Rel(sap, saj2, "Create")
        UpdateRelStyle(sap, saj2, $textColor="black", $lineColor="#555555", $offsetX="-60", $offsetY="155")
        BiRel(sar0, saj0, "HandleOp", "request/response")
        UpdateRelStyle(sar0, saj0, $textColor="black", $lineColor="#04AA6D", $offsetX="-100", $offsetY="30")
        BiRel(sar1, saj1, "HandleOp", "request/response")
        UpdateRelStyle(sar1, saj1, $textColor="black", $lineColor="#f44336")
        BiRel(sar2, saj2, "HandleOp", "request/response")
        UpdateRelStyle(sar2, saj2, $textColor="black", $lineColor="#555555")        
    }
    UpdateLayoutConfig($c4ShapeInRow="1", $c4BoundaryInRow="2")
```

### Dynamic account Operations

Since dynamic account operations requests are less usual, the Scale Agent Plugin flow is as follows:

1. Receive and store the new dynamic account operation on `clouddriver.kubesvc_operation` table
2. Assign the dynamic account operation on `clouddriver.kubesvc_operation_multiple_assign` table; it could be assigned to all connected Scale Agent instance or to instances with the recived zoneId
3. Notify to all instances to fetch pending dynamic account operations from `clouddriver.kubesvc_operation_multiple_assign` table
4. Each instance reads and sends pending dynamic account operations to Scale Agent
5. Wait and send the response back

```mermaid
sequenceDiagram
    actor User
    participant Plugin
    participant Service

    User->>Plugin: Send dynamic account operation
    Plugin->>Plugin: Store in clouddriver.kubesvc_operation
    Plugin->>Plugin: Assign on clouddriver.kubesvc_operation_multiple_assign
    Plugin->>Plugin: Notify all to read and send pending dynamic account operations
    Plugin->>Service: gRPC HandleOp
    Service-->>Plugin: return
    Plugin->>Plugin: Store response in clouddriver.kubesvc_operation_history
    Plugin-->>User: return
```
