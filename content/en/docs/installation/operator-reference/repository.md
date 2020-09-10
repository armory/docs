---
title: Repository Config
weight: 2
description: >
  This page describes `spec.spinnakerConfig.config.repository`.
aliases:
  - /operator_reference/repository/
---


**spec.spinnakerConfig.config.repository**

```yaml
repository:
  artifactory:
    enabled:
    searches:
    - name:
      baseUrl:
      permissions:
        READ:
        WRITE:
      repo:
      groupId:
      repoType:
      username:
      password:
```

## Artifactory

- `enabled`: true or false.
- `searches`:
    - - `name`: The name of the account
      - `baseUrl`: The base url your artifactory search is reachable at.
      - `permissions`:
        - READ: [] A user must have at least one of these roles in order to view this account’s cloud resources.
        - WRITE: [] A user must have at least one of these roles in order to make changes to this account’s cloud resources.
      - `repo`: The repo in your artifactory to be searched.
      - `groupId`: The group id in your artifactory to be searched.
      - `repoType`: The package type of repo in your artifactory to be searched: maven (default).
      - `username`: The username of the artifactory user to authenticate as.
      - `password`: The password of the artifactory user to authenticate as. Supports encrypted value.
