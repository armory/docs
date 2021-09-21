---
title: Configure Dynamic Kubernetes Accounts
linkTitle: Configure Dynamic Accounts
aliases:
  - /spinnaker_install_admin_guides/dynamic_accounts/
  - /spinnaker-install-admin-guides/dynamic_accounts/
  - /docs/spinnaker-install-admin-guides/dynamic-accounts/
description: >
  Use Spinnaker's External Account Configuration feature to manage Kubernetes accounts.
---

## Overview of external account configuration

If you add, delete, or modify Kubernetes deployment targets on a regular basis, you may find that redeploying Clouddriver to pull in new
account configuration impacts your teams. Spinnaker's [External Account Configuration](https://www.spinnaker.io/setup/configuration/#external-account-configuration) feature allows you to manage account configuration
externally from Spinnaker and then read that configuration change without requiring a redeployment of Clouddriver.

> External Account Configuration is only supported for Kubernetes and Cloud Foundry provider accounts. This document describes how this works with Kubernetes acccounts.

Armory does not recommend using External Account Configuration with Spring Cloud Config Server. If you have an existing environment with Spring Cloud Config Server with this setup, see the following KB article: [Configure Spinnaker's External Account Configuration with Vault](https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010418).