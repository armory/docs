---
title: Install Spinnaker on Lightweight Kubernetes using Minnaker
linkTitle: Minnaker
weight: 4
description: >
  Install Spinnaker or Armory Continuous Deployment for Spinnaker in less than 10 minutes in a Lightweight Kubernetes (k3s) environment using the all-in-one, open source command line tool called Minnaker.
---

## Install Spinnaker in 10 minutes using Minnaker

Armory Minnaker is an easy to use installation script that leverages the power of **Kubernetes** with the simplicity of a _Virtual Machine_. Minnaker makes it easy to install Spinnaker and lets you scale your deployment into a medium to large deployment down the road.

The Kubernetes environment that gets installed on your behalf is based on [Rancher's K3s](https://k3s.io/). You do not need to know how to set up Kubernetes. Minnaker takes care of the hard parts for you, allowing you to get Spinnaker up and running in under 10 minutes.

Watch _Spinnaker in 10 minutes or less with Project Minnaker_ for a demo of using Minnaker to install Spinnaker on cloud platforms as well as VMWare Fusion running locally.  

<iframe width="560" height="315" src="https://www.youtube.com/embed/jg8vJEzcuAA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


### Prerequisites for running Minnaker

Your VM should have 4 vCPUs, 16G of memory and 30G of HDD space.

### Getting started

Check out the [GitHub project](https://github.com/armory/minnaker) for more information. After you install Minnaker, use the [AWS Quick Start]({{< ref "Armory-Spinnaker-Quickstart-1" >}}) to learn how to configure Armory to deploy to AWS.
