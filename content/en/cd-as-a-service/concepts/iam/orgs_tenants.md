---
title: Organizations, Tenants, and Users
linkTitle: Orgs, Tenants, Users
description: >
  Learn about stuff.
weight: 10
---


## Overview

```mermaid
classDiagram
    Organization "1" --> "*" Tenant
    Tenant "*" --> "*" User
    Organization "1" --> "*" User
```

* An _Organization_ represents a CD-as-a-Service customer (company), such as Apple or Google. 
* A _User_ is an employee of an Organization. Note that a User can belong to **only one** Organization.
* A _Tenant_ is a an organizational space. 
  * A Tenant has its own configuration, agents, and deployments. 
  * A Tenant belongs to a single Organization, but an Organization can have multiple Tenants. 
  * A Tenant has at least one User, but a User can have access to multiple Tenants.




## {{% heading "nextSteps" %}}

* {{< linkWithTitle "cd-as-a-service/concepts/iam/rbac.md" >}}
* {{< linkWithTitle "cd-as-a-service/tasks/iam/invite-users.md" >}}
