---
title: Feature Status Definitions
linkTitle: Feature Status Definitions
description: >
  Definitions for different features states of Armory Continuous Deployment Self-Hosted or Managed.
aliases:
  - /continuous-deployment/release-notes/release-definitions/
---

## Overview of feature status definitions

Features and plugins that Armory releases have a corresponding status indicating the overall maturity of the feature. This page summarizes those feature status definitions and provides recommendations on where and how you should use them.

## Early Access

![EA](/images/ea.svg)

An _Early Access_ feature is working and installable. However, some functionality is likely to be missing, and a number of known and unknown issues are likely to surface. Armory releases Early Access features to a limited set of technology partners.

### Where to install Early Access

Do not install in a production environment! An Early Access release gives you to use a feature sooner and gives Armory a chance to collect feedback on what is working and not working. Early Access is meant for a closed development environment or a learning environment that can be destroyed at any time and rebuilt.

## Beta

![Beta](/images/beta.svg)

A _Beta_ feature is working, and installation works. All major known issues have been fixed. Armory is working with customers to test the feature. The feature is close to what Armory expects to ship to users.

### Where to install Beta

You could install in a production environment, but proceed with caution and have proper rollbacks ready. If you want to experiment with the feature, Armory recommends using your development, QA, staging, or pre-production environments. A Beta release is meant to give you a chance to set up new features, which makes the transition to a GA release easier. It is also an opportunity to give feedback on any major issues.

## GA

![GA](/images/ga.svg)

All major technical issues have been identified and/or resolved. The feature is available for installation by all customers in the corresponding Armory CD release.

### Where to install GA

All environments.
