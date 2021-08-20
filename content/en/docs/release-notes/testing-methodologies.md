---
title: Testing Methodologies
description: High level overview of how the Armory team tests our releases
---

# CI Process

## Unit Testing

As part of our CI process, we run unit tests with each PR. We push as much to unit tests as possible, to ensure the service works as expected. Between open source and armory, we run thousands of unit tests with each release.

## Integration Testing

As part of the CI process, we also run integration tests, in order to test service to service contracts. This type of testing is great for finding service communication and compatibility issues.

## End-to-End Testing

Once both unit and integration tests pass and a new image is created for use, we run end to end tests. End to end testing helps verify workflows and complex, real world interactions.


# Release Testing

## Manual Testing

After a release candidate is created and has passed all of our automated tests, we perform a series of manual tests.

# On Demand Testing

## Load testing

We conduct load testing when necessary. For instance, we perform load tests in the following scenarios:

- Architectural changes
- Encounter a new unit of scale
  - For example, how does Spinnaker perform as
    - More AWS Accounts are added
    - Number of Cloudwatch metrics increases
    - Increase in Kubernetes namespaces

## Tuning

When installing Spinnaker in a customer environment, because customer environments are unique, we first have to understand the customer&#39;s units of scale. From there, we install a Spinnaker based on a few profiles we&#39;ve tested. After Spinnaker is installed, we utilize monitoring and metrics in order to tune and scale a Spinnaker environment for the customers&#39; units of scale.  See [Spinnaker Monitoring Metrics](https://armory.slab.com/posts/mhge9l4u)
