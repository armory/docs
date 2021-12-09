---
title: Testing Methodologies
description: High level overview of how the Armory team tests releases
toc_hide: true
hide_summary: true
exclude_search: true
---

## CI Process

### Unit Testing

As part of our CI process, we run unit tests with each PR. We push as much to unit tests as possible, to ensure the service works as expected. Between open source and armory, we run thousands of unit tests with each release.

### Integration Testing

As part of the CI process, we also run integration tests, in order to test service to service contracts. This type of testing is great for finding service communication and compatibility issues.

### End-to-End Testing

Once both unit and integration tests pass and a new image is created for use, we run end to end tests. End to end testing helps verify workflows and complex, real world interactions.


## Release Testing

### Manual Testing

After a release candidate is created and has passed all of our automated tests, we perform a series of manual tests.

## On Demand Testing

### Load testing

We conduct load testing when necessary. For instance, we perform load tests in the following scenarios:

- Architectural changes
- Encounter a new unit of scale
  - For example, how does Armory Enterprise perform as
    - More AWS Accounts are added
    - Number of Cloudwatch metrics increases
    - Increase in Kubernetes namespaces

### Tuning

When installing Armory Enterprise in a customer environment, because customer environments are unique, we first have to understand the customer's units of scale. From there, we install a Armory Enterprise based on a few profiles we've tested. After Armory Enterprise is installed, we utilize monitoring and metrics in order to tune and scale a Armory Enterprise environment for the customers' units of scale.  See [Armory Enterprise Monitoring Metrics](https://armory.slab.com/posts/mhge9l4u)
