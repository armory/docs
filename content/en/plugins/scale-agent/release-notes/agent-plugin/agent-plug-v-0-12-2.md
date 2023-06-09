---
title: v0.12.2 Armory Agent Clouddriver Plugin (2023-05-19)
toc_hide: true
version: 00.12.02
date: 2023-05-19
---

## Feature
* Compatibility with custom clouddriver images. Prevents exception `A component required bean named "kubernetesCredentialsLoader"`
* Custom names for credentials loader can be defined using the envvar `CREDENTIALS_LOADER_BEAN_NAME`
