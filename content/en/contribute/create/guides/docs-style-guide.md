---
title:  "Style Guide"
weight: 2
description: >
   Learn the writing guidelines for creating content.
---

## Overview

This page gives writing style guidelines for the Armory documentation. Since these are guidelines, not rules, use your best judgment when creating content. Feel free to propose changes to this document in a pull request.

This a subset of the [Google developer documentation style guide](https://developers.google.com/style). The Docs team uses that guide for anything not listed here.

## {{% heading "prereq" %}}

Make sure you have read the {{< linkWithTitle "content-guide.md" >}}.

## Language

The Armory documentation uses U.S. English spelling and grammar. However, use the international standard for putting punctuation outside of quotation marks.

| **Do**                                    | **Do Not**                                |
|:----------------------------------------- |:----------------------------------------- |
| Your copy of the repo is called a "fork". | Your copy of the repo is called a "fork." |


We also use [Oxford commas](https://visual.ly/community/infographic/humor/oxford-comma)(serial commas).



Create content using [Markdown](https://www.markdownguide.org/) with your favorite IDE.

## Best practices for clear, concise, and consistent content

### Use present tense

|**Do** |**Do Not**|
|:------|:---------|
| This command adds a plugin. 	| This command will add a plugin. 	|

Exception: Use future or past tense if it is required to convey the correct meaning.

### Use active voice

|**Do** |**Do Not**|
|:------|:---------|
| You can explore the API using a browser. | The API can be explored using a browser. |
| Orca supports the following storage backends for storing execution state: | The following storage backends are supported for storing execution state: |

Exception: Use passive voice if active voice leads to an awkward construction.

### Use simple and direct language

Use simple and direct language. Avoid using unnecessary phrases like "please".

|**Do** |**Do Not**|
|:------|:---------|
| To create an Artifact, ... | In order to create an Artifact, ...|
| See the configuration file. | Please see the configuration file.|
| View the Pipeline logs. | With this next command, we'll view the Pipeline logs.|

### Address the reader as "you"

|**Do** |**Do Not**|
|:------|:---------|
| You can create a Pipeline by ... | We'll create a Pipeline by ...|
| In the preceding output, you see... | In the preceding output, we see ...|

### Avoid Latin phrases

Use English terms over Latin abbreviations.

|**Do** |**Do Not**|
|:------|:---------|
| For example, ... | e.g., ...|
| That is, ...| i.e., ...|

Exception: Use "etc." for et cetera.

### Paragraphs

Try to keep paragraphs short, under 6 sentences, and limit to a single topic.

### Links

Use hyperlinks that give the reader context for the linked content. Avoid ambiguous phrases like "click here" in favor of descriptive ones.

For example, use
~~~~~~~~~~
See the [Repository structure](https://github.com/pf4j/pf4j-update#repository-structure) section of the PF4J README for details.
~~~~~~~~~~

rather than
~~~~~~~~~~
Click [here](https://github.com/pf4j/pf4j-update#repository-structure) to read more.
~~~~~~~~~~

For long URLs, consider using [reference-style hyperlinks](https://www.markdownguide.org/basic-syntax/#reference-style-links) to maintain readability of the Markdown file.

## Patterns to avoid

### Avoid using "we"

Do not use "we" because readers may not know if they are part of the "we".

|**Do** |**Do Not**|
|:------|:---------|
| Version 1.19.0 includes ... | In version 1.19.0, we have added ...
| Armory Continuous Deployment provides a new feature for ... | We provide a new feature for ...|
| This guide teaches you how to use Plugins. | In this guide, we are going to learn about Plugins.|

### Avoid jargon and idioms

Avoid jargon and idioms to help non-native English speakers understand the content better.

|**Do** |**Do Not**|
|:------|:---------|
| Internally, ...| Under the hood, ...|
| Create a new instance. | Spin up a new instance.|

### Avoid statements about the future

If you need to write about an alpha feature, use the `alpha` include tag to denote the Armory Continuous Deployment version. You can also put a note under a heading that identifies it as alpha information. However, do not include statements about when the feature will no longer be alpha, or what will change.

`alpha` include example:

{% include alpha version="1.19.4" %}

### Avoid statements that will soon be out of date

Avoid using words like "currently" and "new." A feature that is new today might not be considered new in a few months.

|**Do** |**Do Not**|
|:------|:---------|
| In version 1.4, ... | In the current version, ...|
| The Plugins feature provides ... | The new Plugin feature provides ...|

## Documentation formatting standards

### Use Capital case for page titles

|**Do** |**Do Not**|
|:------|:---------|
| Documentation Style Guide | Documentation style guide |
| Connect Docker Registries | Connect Docker registries |

### Use sentence capitalization for headings

~~~~~~~~~
## Create a custom webhook stage

## Configure parameters for custom webhook stages
~~~~~~~~~

### Line breaks

Use a single newline to separate block-level content like headings, lists, images, code blocks, paragraphs, and others.

### Use camel case for API objects

Use the same uppercase and lowercase letters that are used in the
actual object name when you write about API objects. The names of API objects use [Camel case](https://en.wikipedia.org/wiki/Camel_case).

Don't split the API object name into separate words. For example, use CredentialsController, not Credentials Controller.

Refer to API objects without saying "object," unless omitting "object" leads to an awkward construction.

|**Do** |**Do Not**|
|:------|:---------|
| The PipelineController restarts a Stage. | The pipeline controller restarts a stage.|
| The AmazonInfrastructureController is responsible for ... | The AmazonInfrastructureController object is responsible for ...|

### Kubernetes objects

See the following Kubernetes Documentation Style Guide sections:

* [Use upper camel case for API objects](https://kubernetes.io/docs/contribute/style/style-guide/#use-upper-camel-case-for-api-objects)
* [Use code style for inline code, commands, and API objects](https://kubernetes.io/docs/contribute/style/style-guide/#code-style-inline-code)
* [Use code style for object field names and namespaces](https://kubernetes.io/docs/contribute/style/style-guide/#use-code-style-for-object-field-names-and-namespaces)
* [Use code style for Kubernetes command tool and component names](https://kubernetes.io/docs/contribute/style/style-guide/#use-code-style-for-kubernetes-command-tool-and-component-names)
* [Starting a sentence with a component tool or component name](https://kubernetes.io/docs/contribute/style/style-guide/#starting-a-sentence-with-a-component-tool-or-component-name)
* [Use a general descriptor over a component name](https://kubernetes.io/docs/contribute/style/style-guide/#use-a-general-descriptor-over-a-component-name)
* [Referring to Kubernetes API resources](https://kubernetes.io/docs/contribute/style/style-guide/#referring-to-kubernetes-api-resources)

### Use angle brackets for placeholders

Use angle brackets for placeholders. Describe what a placeholder represents.

For example:
`hal plugins repository add <unique-repo-name> --url <repo-url>`


### Use bold for user interface elements

|**Do** |**Do Not**|
|:------|:---------|
| Click **Fork**.| Click "Fork".|
| Select **Other**. | Select "Other".|

You should code cascading menus like this:

```
**Options** > **About Me**> **Edit Profile**
```

Rendered as: **Options** > **About Me**> **Edit Profile**

### Use italics to define or introduce new terms

|**Do** |**Do Not**|
|:------|:---------|
|A _Stage_ is a step in a pipeline ... | A "Stage" is a step in a pipeline ...|

### Use code style for filenames, directories, and paths

|**Do** |**Do Not**|
|:------|:---------|
| Open the `rosco.yaml` file. | Open the rosco.yaml file.|
| Go to the `/docs/tutorials` directory. | Go to the /docs/tutorials directory.|
| Open the `/.hal/config` file. | Open the /.hal/config file.|

### Lists

Group items in a list that are related to each other. Use a numbered list for instructions that need to be completed in a specific order.

 - End each item in a list with a period if one or more items in the list are complete sentences. For the sake of consistency, normally either all items or none should be complete sentences.
 - Use the number one `1.` for each item in an ordered list.
 - Use (+), (* ), or (-) for unordered lists.
 - Leave a blank line after each list.
 - Indent nested list items with one tab
 - List items may consist of multiple paragraphs. Each subsequent paragraph in a list item must be indented by either four spaces or one tab.
 - Indent nested list items by either four spaces or one tab.
 - The first line of a code block should be indented **three** spaces. For example, an ordered list with a code block looks like this in Markdown:

   ```markdown
	 1. Do this
	 1. Do this
	 1. Do this
	 1. Run these commands:

	    ```
		  curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/debian/InstallHalyard.sh
		  sudo bash InstallHalyard.sh
		  ```

	 1. Do the next thing
   ```

   The rendered output looks like:

   1. Do this
   1. Do this
   1. Do this
   1. Run these commands:

      ```bash
		  curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/debian/InstallHalyard.sh
		  sudo bash InstallHalyard.sh
		  ```

   1. Do the next thing

See the [Markdown Guide](https://www.markdownguide.org/basic-syntax/#lists) for more list examples.

## Inline code formatting

### Use code style for inline code and commands

Use meaningful variable names that have a context rather than  'foo','bar', and similar meaningless variable names.

Use a single backtick (\`) to surround inline code in a Markdown document. In Markdown:

~~~~~~~~~
Run `hal deploy apply` to deploy Armory Continuous Deployment.
~~~~~~~~~

renders as:

Run `hal deploy apply` to deploy Armory Continuous Deployment.

Use triple backticks to enclose a code block. In Markdown:

~~~~~~~~~
```json
{
  "firstName": "John",
  "lastName": "Smith",
  "age": 25
}
```
~~~~~~~~~

renders as:

```json
{
  "firstName": "John",
  "lastName": "Smith",
  "age": 25
}
```

Remove trailing spaces in all code blocks.

### Don't include the command prompt in code snippets

|**Do** |**Do Not**|
|:------|:---------|
hal deploy apply| $ hal deploy apply

### Separate commands from output

Verify that the Pod is running on your chosen node:

    kubectl get pods --output=wide

The output is similar to this:

    NAME     READY     STATUS    RESTARTS   AGE    IP           NODE
    nginx    1/1       Running   0          13s    10.200.0.4   worker0

### Use normal style for string and integer field values

For field values of type string or integer, use code style instead of quotation marks.

| **Do** | **Do Not** |
|:----- |:---------- |
| Set the value of `enabled` to `True`.    | Set the value of `enabled` to "True".   |
| Set the value of `image` to `nginx:1.8`. | Set the value of `image` to "nginx:1.8." |
| Set the value of `maxWaitTime` to `30`.  | 'Set the value of `maxWaitTime` to "30".' |

## Versioning Armory CD examples

Code examples and configuration examples that include version information should be consistent with the accompanying text.

If the information is version specific, the Armory version needs to be defined in the **{{% heading "prereq" %}}** section of the guide.

## Armory word list

A list of specific terms and words to be used consistently across the docs:

| **Do**   | **Do Not**  |
|:----|:-----|
| Kubernetes | kubernetes |
| Docker  | docker |
| On-premises or on-prem | On-premise or other variations. |  
| Multicloud | Multi-cloud |
| Open source  | Open-source |


- **Cloud Native** this appears as cloud native and cloud-native; generally:
    - Use cloud-native with they hypen when you use it as an adjective, when referring to technologies, systems, platforms, applications
        - cloud-native applications; cloud-native platforms, like Kubernetes…;
        - “cloud native" or "Cloud Native” when the term is used as a noun
- Plugins/Plugin Framework - Technically, the proper American English term is plug-in, but tech seems to prefer it it without a hyphen.
- Repository - repos is fine
- Continuous Integration/Continuous Delivery (CI/CD)
- **Blue/Green** deployment (not Blue-Green)
    - AWS, The New Stack, Kubernetes, Spinnaker all use "Blue/Green"
    - blue/green
    - Blue/green

- Data center (not datacenter)
- Em dash — space on either side
- En dash ­– for ranges
- Toward (not towards)
- Companies _that_, people _who_
- Global 2000 companies, not Global 2,000 companies (Forbes refers to “Global 2000”)
- always lowercase in sentences: kubeconfig, kubectl, kubeadm, kubelet
- blitzscale, blitzscaling
- on-premises; not _on prem_ or _on premise_ Use to refer to a customer&#39;s resources that they manage in their own facilities. Don&#39;t use _peer_. Hyphenate when used as any part of speech. It can be acceptable to use _on-premises_ as a noun when it would be awkward to repeatedly write out a full phrase like _an on-premises environment_. However, it&#39;s preferable to use the more complete phrase whenever possible. ([https://developers.google.com/style/word-list#letter-o](https://developers.google.com/style/word-list#letter-o))
- setup vs set up
   - setup is a noun
   - set up is a verb
   - https://writingexplained.org/setup-vs-set-up-difference
- into vs in to
   - https://writingexplained.org/into-vs-in-to-difference


## Armory products list


| **Name** | **Shortened Name** | Notes |
| --- | --- | --- |
| Armory Continuous Deployment | Armory CD | |
| Armory Continuous Deployment Self-Hosted | Armory CD Self-Hosted | |
| Armory Continuous Deployment Managed | Armory CD Managed | |
| Pipelines-as-Code |  |  |
| Pipeline Policies |  | Policy Engine | OPA is the Open Policy Agent. It is the OSS project that the Policy Engine uses. Guardian is an internal code  name for a possible future state of policy engine. |
| Terraform Integration (Stage) |  | Terraformer is the microservice behind the integration b/c the feature uses Terraform, an OSS project &quot;owned&quot; by Hashicorp  |
| Armory Operator | Operator | Different from the Spinnaker Operator, which is open source software |
| Spinnaker Operator | Operator |  |
| Armory Scale Agent for Spinnaker and Kubernetes  |  Scale Agent |   |
| Plugin Framework | Plugins | No `-` in plugin. |
| Evaluate Artifacts Stage |  | A feature available in armory enterprise, not a stand alone offering. |
| Automated Impact Analysis || Automated Canary Analysis |   |
| Armory Continuous Deployment-as-a-Service | Armory CD-as-a-Service or CD-as-a-Service |  |
| CD-as-a-Service Cloud Console | Cloud Console |  |


## Products we frequently refer to

One of the key parts of Armory CD is that it integrates with a ton of stuff that isn't ours.

When in doubt, check the company’s website.

| Official name | Shortened name | Example of when/how to refer to it |
| --- | --- | --- |
| Open Policy Agent | OPA | Policy Engine checks policy against OPA. |
| Amazon Web Services | AWS | Spinnaker can deploy to AWS |
| Elastic Compute Cloud | EC2 | Spinnaker can deploy EC2 instances after baking an AMI for them. |
| NGINX, NGINX Plus, NGINX Controller|  | |


## {{% heading "nextSteps" %}}

{{< linkWithTitle "diagram-guide.md" >}}
<br><br>