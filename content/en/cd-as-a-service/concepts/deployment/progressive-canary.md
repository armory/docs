---
title: Progressive Canary Deployment
linktitle: Progressive Canary
description: >
  Learn about service mesh traffic management for your canary strategy.

---

## {{% heading "prereq" %}}

You should be familiar with {{< linkWithTitle "cd-as-a-service/concepts/deployment/traffic-mgmt.md" >}}.

## Overview

A progressive canary deployment — not to be confused with canary analysis — incrementally shifts traffic between two versions of your software. You can, for example, define a deployment that looks like this:

- Send 25% of incoming traffic to the new version of my software
- Run a metric analysis (e.g., verify that no more than 1% of HTTP requests return a 5xx status code during the analysis period)
- Run integration tests
- If the preceding two steps succeed, bump the traffic weight to 100% and tear down the old version of my software

A progressive canary deployment is a kind of interface. Armory CD-as-a-Service offers two progressive canary implementations: pod-ratio canary and SMI canary.

In a pod-ratio canary, we shape traffic by controlling the relative number of pods of each version of your software. Pod-ratio canaries are great, and most of the internal services that comprise Armory CD-as-a-Service use it to deploy themselves. There are, however, some limitations:

- **Traffic granularity**: in a pod-ratio canary, it's not always possible to achieve highly granular traffic shifts. If your application typically runs as a cluster of four pods, it's not possible to send a tiny percentage of traffic — e.g., 1% — to the new version of your software. If you're trying to maintain an ambitious SLA, coarse-grained traffic weighting may not be acceptable to you.
- **Traffic shift and rollback time**: since the pod-ratio strategy scales pods up and down to shift traffic, traffic shifts and rollbacks can be slow if your application boots slowly. This can be scary if you need to roll back quickly.
For those that like to get straight to the point (and would like to skip to the end of the article): our implementation of progressive canary with SMI solves both of these problems.

## Progressive Canary with SMI Traffic Split

Armory CD-as-a-Service uses SMI's `TrafficSplit` resource to implement progressive canary deployments.

A `TrafficSplit` defines, declaratively, how traffic should be weighted across two or more groups of pods under a single cluster-local domain name. Clients can call a single address and talk, with a defined likelihood, to one of several different versions of your software.

A split is a powerful tool but, on its own, it can't deploy your software. It needs to be used in concert with other tools: as the SMI spec says, "the resource itself [i.e., SMI `TrafficSplit`] is not a complete solution as there must be some kind of controller managing the traffic shifting over time."

Armory CD-as-a-Service is this controller — it's the coordinator that scales up the new version of your software, waits for it to become healthy, safely shifts traffic by updating a `TrafficSplit`, and shuts down the old version of your software once you're certain that your deployment is healthy. Apart from installation, you don't need any knowledge of SMI or your service mesh to use CD-as-a-Service - we're responsible for creating all of the auxiliary resources and cleaning them up when we're done.

A canary deployment with SMI has the following advantages over a pod-ratio canary:

- You can choose any integer traffic weight for the new version of your software, regardless of the size of your deployment. In the future we may support fractional traffic weights (e.g., 0.1%)
- Traffic shifts and rollbacks are nearly instantaneous and not dependent on scale up or scale down time.

## Supported service mesh products

* [Linkerd](https://linkerd.io/)


## {{%  heading "nextSteps" %}}

- {{< linkWithTitle "cd-as-a-service/tasks/deploy/traffic-management.md" >}}



