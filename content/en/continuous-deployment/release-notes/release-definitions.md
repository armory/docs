---
title: Armory Continuous Deployment Release Definitions
linkTitle: Armory CD Release Definitions
description: >
  Definitions for different release states of Armory Continuous Deployment Self-Hosted or Managed
---

## Overview of the definitions for different release states

Each one of these release definitions is for Armory Continuous Deployment and where you should or should not install a release or feature in one of these stages. Regardless of what stage a feature is in, Armory would love to hear some feedback about it.

## Experiment

An _experiment_ is a test version of a new feature that we think will solve some of your pain points. This is your opportunity to provide us feedback. We want to hear the good, the bad, and the ugly, so we can create the best feature to solve your problem.

### Where to install an Experiment

Not production! No, really don’t do it! An experimental feature is meant to give the user access to a concept we think would be useful and gives Armory a chance to collect feedback on validating the usefulness and direction of the feature. Experiments are meant for a closed development environment or a learning environment that can be destroyed at any minute and rebuilt.

## Early Access

An _Early Access_ feature is working and installable. However, some functionality is likely to be missing, and a number of known and unknown issues are likely to surface. Early Access features are released to a limited set of technology partners.

### Where to install Early Access

Not production! No, really don’t do it! This release is meant to give the user an advanced ability to get to know a feature sooner and gives Armory a chance to collect feedback on what is working and not working. Early Access is meant for a closed development environment or a learning environment that can be destroyed at any minute and rebuilt.

## Beta

The feature is working, and installation works. All of the major known issues are fixed, Armory is working with customers to test the feature out. It's close to what we expect to ship to our users.

### Where to install Beta

Pretty much anywhere except production. A production installation could occur but proceed with caution and have proper rollbacks ready. If you want to experiment with the feature, Armory recommends using your development, QA, staging, or pre-prod environments. This release is meant to give the user a chance to set up new functionality and hit the ground running when GA releases. It is also an opportunity to give feedback on any final major issues.

## GA

All major technical issues have been identified and/or resolved. The application is available for install by all customers in the official Armory release.

### Where to install GA

Anywhere you like.
