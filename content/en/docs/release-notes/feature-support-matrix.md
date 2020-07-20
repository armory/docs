---
title: Feature Support Matrix
description: "Information about support for Armory Enterprise (ARME) and Open Source Spinnaker™ (OSS) features."
---

This page describes the Armory Enterprise and OSS features and their state.

<!-- If you don't want to make markdown tables manually, use something like https://www.tablesgenerator.com/markdown_tables# -->


## Observability Plugin 

(OSS)

## Pipelines as Code 

(ARME) Pipelines as Code gives you the ability to manage your pipelines and their templates in source control.

**State**: GA

Read more about what GA means [here]({{< ref "release-definitions" >}}).

**Supported version control systems**

| Feature   | Armory Enterprise version | Notes                  |
|-----------|---------------------------|------------------------|
| BitBucket | All supported versions    |                        |
| GitHub    | All supported versions    | Enterprise and vanilla |

**Features**

| Feature | Armory Enterprise version | Notes |
|---------|---------------------------|-------|
| XYZ     | All supported versions    |       |
| ABC     | 2.20 and later            |       |

## Policy Engine for the SDLC

(ARME)

**State**: GA

Read more about what GA means [here]({{< ref "release-definitions" >}}).

**Supported OPA server versions**

**Features**

| Feature              	| Armory Enterprise version 	| Notes                                              	|
|----------------------	|---------------------------	|----------------------------------------------------	|
| Runtime Validation   	| 2.20 and later            	| If no policies are configured, all pipelines pass. 	|
| Save time Validation 	| All supported versions    	| If no policies are configured, all pipelines fail. 	|

## Terraform Integration 

(ARME) The Terraform Integration gives you the ability to use Terraform within your Spinnaker pipelines.

**State**
* GA

Read more about what GA means [here]({{< ref "release-definitions" >}}).

**Supported Terraform versions**
* Versions ABC to XYZ
  
**Features**

| Feature                           | Armory Enterprise version | Notes |
|-----------------------------------|---------------------------|-------|
| Base Terraform Integration        | All supported versions    |       |
| Named Profiles with authorization | 2.20 and later            |       |