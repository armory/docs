---
title: Hugo and Docsy Tips and Tricks
description: >
  Tips and tricks for creating content.
---

## Hugo static site generator

Hugo is a robust static site generator that supports templates. In addition to being written in Go instead of Ruby, the site build times are drastically improved. You can see your changes in milliseconds.

You can preview changes you or others make by doing one of the following:

- building the site locally by installing Hugo locally with `brew install hugo`. If you installed your tooling from the Engineering brewfile, you already have Hugo: [Eng onboarding brewfile](https://github.com/armory-io/engineering-toolset/tree/master/software)
- You also have to initialize the submodules in the `docs` repo to build locally:

   ```
   git submodule update --init --recursive
   ```

- Viewing the preview build in the PR

Resources you can consult for more info:

- [docsy.dev/docs](https://www.docsy.dev/docs/) (This is the theme  will use too)
- [gohugo.io](https://gohugo.io/)

## How Hugo generates `meta` tags from front matter and page content

It there is a `description` in the front matter, Hugo generates meta tags using the content of that `description`. For example:

```
---title: Armory Operatorweight: 1description: >  The Armory Operator is a Kubernetes Operator that makes it easy to install, deploy, and upgrade any version of Armory.aliases:
  - /docs/spinnaker/operator/---
```

Hugo generates these meta tags:

```
<title>Armory Operator | Armory Documentation</title><meta property="og:title" content="Armory Operator" />
<meta property="og:description" content="The Armory Operator is a Kubernetes Operator that makes it easy to install, deploy, and upgrade any version of Armory." />
<meta property="og:type" content="article" />
<meta property="og:url" content="/docs/installation/operator/" />
<meta property="article:modified_time" content="2020-11-30T09:29:25-08:00" /><meta property="og:site_name" content="Armory Documentation" />
<meta itemprop="name" content="Armory Operator"><meta itemprop="description" content="The Armory Operator is a Kubernetes Operator that makes it easy to install, deploy, and upgrade any version of Armory."><meta itemprop="dateModified" content="2020-11-30T09:29:25-08:00" />
<meta itemprop="wordCount" content="1798"><meta itemprop="keywords" content="" /><meta name="twitter:card" content="summary"/>
<meta name="twitter:title" content="Armory Operator"/>
<meta name="twitter:description" content="The Armory Operator is a Kubernetes Operator that makes it easy to install, deploy, and upgrade any version of Armory."/>
```

If there isn’t a description, Hugo uses the first 70 words of your content. For example:

```
---title: Enabling the Terraform Integration Stagealiases:
  - /spinnaker/terraform_integration/
  - /spinnaker/terraform-configure-integration/
  - /docs/spinnaker/terraform-enable-integration/---## Overview

The examples on this page describe how to configure the Terraform Integration and an artifact provider to support either GitHub or BitBucket. Note that the Terraform Integration also requires a `git/repo` artifact account. For information about how to use the stage, see [Using the Terraform Integration]({{< ref "terraform-use-integration" >}}).

Armory's Terraform Integration integrates your infrastructure-as-code Terraform workflow into your SDLC. The integration interacts with a source repository you specify to deploy your infrastructure as part of a Spinnaker pipeline.
```

Hugo generates these meta tags:

```
<title>Enabling the Terraform Integration Stage | Armory Documentation</title><meta property="og:title" content="Enabling the Terraform Integration Stage" />
<meta property="og:description" content="Overview The examples on this page describe how to configure the Terraform Integration and an artifact provider to support either GitHub or BitBucket. Note that the Terraform Integration also requires a git/repo artifact account. For information about how to use the stage, see Using the Terraform Integration.Armory&rsquo;s Terraform Integration integrates your infrastructure-as-code Terraform workflow into your SDLC. The integration interacts with a source repository you specify to deploy your infrastructure as part of a Spinnaker pipeline." />
<meta property="og:type" content="article" />
<meta property="og:url" content="/docs/armory-admin/terraform-enable-integration/" />
<meta property="article:modified_time" content="2020-10-12T11:43:09-07:00" /><meta property="og:site_name" content="Armory Documentation" />
<meta itemprop="name" content="Enabling the Terraform Integration Stage"><meta itemprop="description" content="Overview The examples on this page describe how to configure the Terraform Integration and an artifact provider to support either GitHub or BitBucket. Note that the Terraform Integration also requires a git/repo artifact account. For information about how to use the stage, see Using the Terraform Integration.Armory&rsquo;s Terraform Integration integrates your infrastructure-as-code Terraform workflow into your SDLC. The integration interacts with a source repository you specify to deploy your infrastructure as part of a Spinnaker pipeline."><meta itemprop="dateModified" content="2020-10-12T11:43:09-07:00" />
<meta itemprop="wordCount" content="2196"><meta itemprop="keywords" content="" /><meta name="twitter:card" content="summary"/>
<meta name="twitter:title" content="Enabling the Terraform Integration Stage"/>
<meta name="twitter:description" content="Overview The examples on this page describe how to configure the Terraform Integration and an artifact provider to support either GitHub or BitBucket. Note that the Terraform Integration also requires a git/repo artifact account. For information about how to use the stage, see Using the Terraform Integration.Armory&rsquo;s Terraform Integration integrates your infrastructure-as-code Terraform workflow into your SDLC. The integration interacts with a source repository you specify to deploy your infrastructure as part of a Spinnaker pipeline."/>
```



## Experimental Feature

Armory releases features in different states. The experimental shortcode makes it very clear that you shouldn't use the feature in production. Use it at the start of your page immediately following the front matter:

```
---
frontmatter
---

{{< include "experimental-feature.html" >}}

## Your first section
```

## Reusing text

Have something that you need consistent across multiple pages, such as a known issue in the release notes? Make an include!

See examples in `content/en/includes` and any release notes page.

## Link to other pages in the docs

Hugo has two useful shortcodes, `ref` and `relref`, for linking to other pages within the docs.

`ref` relies on unique file names. This method is preferred because we don&#39;t have to update relative file paths in links when we reorganize content. Code:

```
[ref link to Overview - Load Balancers]({{</* ref "load-balancers" */>}})

[SpinnakerService Options]({{</* ref "operator-config#specspinnakerconfigfiles"  */>}})
```

The second is `relref`, which requires the complete path to the file. Code:

```
[relref link to Overview - Load Balancers]({{</* relref "/docs/overview/load-balancers" */>}})
```

The third option option is the custom `linkWithTitle` shortcode, which displays the page's title as the link text.

```
See the {{</* linkWithTitle "artifacts-ecr-connect" */>}} guide for details.
```
