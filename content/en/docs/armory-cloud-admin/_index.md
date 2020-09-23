---
title: "Armory Cloud Admin"
description: Administer your Armory Cloud environment
---

## Overview

Armory Cloud is a SaaS platform for continuous delivery that integrates with your existing tools:

- Artifact stores, such as GitHub, to fetch things like images
- Cloud Providers, such as AWS, to deploy your applications to
- Pipeline Triggers, such as Google Pub/Sub, to trigger pipelines automatically
- Canary Integrations, such as DataDog, to help you perform Canary deployments

The two main components of Armory Cloud are Armory Cloud Console and a cloud instance of the Armory Platform. Armory Cloud Console is the administrator portal for your Armory Cloud instance. In the portal, you can perform administrative and operations related tasks, such as configuring your Armory Cloud environments (such as sandbox and production environments) and the integrations mentioned. The Armory Platform, which includes Armory's enterprise extensions of Spinnaker™, is where your application developers create and manage their delivery pipelines within the environments you 