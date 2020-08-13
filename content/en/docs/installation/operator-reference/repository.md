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
    - baseUrl:
      repo:
      groupId:
      repoType:
      username:
      password:
```

## Artifactory

- `enabled`: true or false.
- `searches`:
    - `- baseUrl`: The base url your artifactory search is reachable at.
      - `repo`: The repo in your artifactory to be searched.
      - `groupId`: The group id in your artifactory to be searched.
      - `repoType`: The package type of repo in your artifactory to be searched.
      - `username`: The username of the artifactory user to authenticate as.
      - `password`: The password of the artifactory user to authenticate as. Supports encrypted value.
