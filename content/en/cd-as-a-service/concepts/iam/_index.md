---
title: Access Management Concepts
linkTitle: Access Management
description: >
  In this section, learn about Access Management in Armory CD-as-a-Service.
categories: ["CD-as-a-Service"]
tags: ["Concepts", "OIDC", "Access Management"]
---

## Armory CD-as-a-Service Access Management

Armory CD-as-a-Service uses OIDC to authenticate both user and machine principals and issue short-lived access tokens, which are signed JSON web tokens (JWTs).

The Armory CD-as-a-Service API consumes these access tokens in order to validate that a request has authorization for a given tenant’s resources and operations.

Use the the [CD-as-a-Service Console](https://console.cloud.armory.io/) to manage the following:

- Credentials for machines and scope them for specific permissions and use cases
- Users
- OIDC based external identity providers (IdP), such as Okta, Auth0, or OneLogin

