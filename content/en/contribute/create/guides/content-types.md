---
title: "Content Page Types"
description: >
  Learn about the different types of content
---

## Concept

Use this page type when you want to introduces a single concept or feature. The content is objective, containing architecture, definitions, rules, and guidelines. Rather than containing a sequence of steps, these pages link to related tasks and tutorials.

A concept page explains what something is, not how to use it. You can link to a Task page that explains how to use the feature.

If you start explaining a second concept on your page, create a new page for the new concept and link to it.

### Structure

Each page must have `frontmatter` at the top of the page so Hugo can compile it into HTML.

```markdown
---
title: <descriptive page title>
linkTitle: <short title for site navigation>
description: >
   <what the page is about; search engines display this in results>
---
```

- `title`: Your page title should contain keyword nouns that search engines can use. For example, if you want to explain how CD-as-a-Service implements Kubernetes HPA, you could create a page title like one of the following:
   - How CD-as-a-Service Implements Kubernetes Horizontal Pod Autoscaling
   - Kubernetes Horizontal Pod Autoscaling in CD-as-a-Service
- `linkTitle`: This is a short, meaningful version of your title for site navigation. For example, if your title is "How CD-as-a-Service Implements Kubernetes Horizontal Pod Autoscaling", your `linkTitle` could be "Kubernetes HPA".
- `description`: This is one or two sentences that describe the topic of your page. Hugo compiles this into a `<meta description>` tag. Search engines use this content when displaying search results, so the description should contain keywords. For example, if your title is "How CD-as-a-Service Implements Kubernetes Horizontal Pod Autoscaling", your description could be "Learn how Armory CD-as-a-Service implements Kubernetes HAP by changing your Kubenetes Deployment to a ReplicaSet and rewriting your HPA to reference that ReplicaSet."

Pull request approvers check the frontmatter fields and can help with good wording for search engine optimization.

The body of your page should have one or more headings that organize your page into meaningful sections.

```markdown
## < heading for concept overview >

## < {{%/* heading "prereq" */%}} >

## < heading for body >

## < {{%/*  heading "nextSteps" */%}} >
```

- `heading for concept overview`: Avoid using "Overview" or "Introduction" as the sole word in the heading. This paragraph should set the context in one or two sentences. You can omit this section if you put your concept overivew in the frontmatter's `description` field. Headings should be short, descriptive, and optimized for search engines.
- `{{%/* heading "prereq" */%}}`: (Optional) Include links to prerequisite material that the reader should know in order to understand your concept. This heading is a Hugo shortcode that compiles to "Before you begin".
- `< heading for body >`: The body should explain the concept or feature. You can include additional headings and subheadings.
- `{{%/*  heading "nextSteps" */%}}`: (Optional) Link to related concepts, tasks, and/or tutorials. This heading is a Hugo shortcode that compiles to "Next steps".

## Task

Think of a task as a simple, discreet use case. A Task page shows you how to do a single procedure by following a short series of steps that produce an intended outcome. Task content expects a minimum level of background knowledge, and each page links to conceptual content that you should be familiar with before you begin the task. Additionally, a task should list prerequisite steps the reader needs to complete before starting the task.

### Structure

Each page must have `frontmatter` at the top of the page so Hugo can compile it into HTML.

```markdown
---
title: <descriptive page title>
linkTitle: <short title for site navigation>
description: >
   <what the page is about; search engines display this in results>
---
```

- `title`: Your page title should start with an active verb and contain keyword nouns that search engines can use. For example, if you want to explain how to configure mTLS in the Armory Agent, you could create a page title such as "Configure Mutual TLS Authentication".
- `linkTitle`: This is a short, meaningful version of your title for site navigation. For example, if your title is "Configure Mutual TLS Authentication", your `linkTitle` could be "Configure mTLS".
- `description`: This is one or two sentences that describe the topic of your page. Hugo compiles this into a `<meta description>` tag. Search engines use this content when displaying search results, so the description should contain keywords. For example, if your title is "Configure Mutual TLS Authentication", your description could be "Learn how to configure mTLS authentication in the Armory Scale Agent for Spinnaker and Kubernetes plugin and service."

Pull request approvers check the frontmatter fields and can help with good wording for search engine optimization.

The body of your page should have one or more headings that organize your page into meaningful sections.

```markdown
## < heading for task overview >

## < {{%/* heading "prereq" */%}} >

## < task steps >

## < {{%/*  heading "nextSteps" */%}} >
```

- `heading for task overview`: Avoid using "Overview" or "Introduction" as the sole word in the heading. This paragraph should set the objectives in one or two sentences. You can omit this section if you put your task overivew in the frontmatter's `description` field. Headings should be short, descriptive, and optimized for search engines.
- `{{%/* heading "prereq" */%}}`: Include a bullet list of links to prerequisite material that the reader should know or have done in order to perform the task. This heading is a Hugo shortcode that compiles to "Before you begin".
- `< task steps >`: The body should contain steps to complete the task. The steps can be in a numbered list or separate headings.
- `{{%/*  heading "nextSteps" */%}}`: (Optional) Link to related concepts, tasks, and/or tutorials. This heading is a Hugo shortcode that compiles to "Next steps".


## Tutorial

A tutorial is an end-to-end example of how to do accomplish a goal and is comprised of several tasks performed in sequence. For example, a CD-as-a-Service tutorial might show you how to deploy an demo app by cloning a repo, logging in using the CLI, creating a deployment file, and finally deploying the app. Like a task, a tutorial should link to content you should know and items you should complete before starting the tutorial.

### Structure

Each page must have `frontmatter` at the top of the page so Hugo can compile it into HTML.

```markdown
---
title: <descriptive page title>
linkTitle: <short title for site navigation>
description: >
   <what the page is about; search engines display this in results>
---
```

- `title`: Your page title should start with an active verb and contain keyword nouns that search engines can use. For example, if you want to explain how to deploy a demo app that uses a GitHub webhook-based approval in CD-as-a-Service, you could create a page title such as "Deploy a Demo App That Uses GitHub Webhook-Based Approval".
- `linkTitle`: This is a short, meaningful version of your title for site navigation. For example, if your title is "Deploy a Demo App That Uses GitHub Webhook-Based Approval", your `linkTitle` could be "GitHub Webhook Approval".
- `description`: This is one or two sentences that describe the topic of your page. Hugo compiles this into a `<meta description>` tag. Search engines use this content when displaying search results, so the description should contain keywords. For example, if your title is "Deploy a Demo App That Uses GitHub Webhook-Based Approval", your description could be "Learn how to configure a GitHub webhook-based approval in your Armory CD-as-a-Service app deployment process."

Pull request approvers check the frontmatter fields and can help with good wording for search engine optimization.

The body of your page should have one or more headings that organize your page into meaningful sections.

```markdown
## < tutorial objectives >

## < {{%/* heading "prereq" */%}} >

## < steps >

## < {{%/*  heading "nextSteps" */%}} >
```

- `tutorial objectives`: This section should set the objectives in bullet points or a few short sentences.  
- `{{%/* heading "prereq" */%}}`: Include a bullet list of links to prerequisite material that the reader should know or have done in order to perform the task. This heading is a Hugo shortcode that compiles to "Before you begin".
- `< steps >`: The body should contain steps to complete the tutorial. The steps should be in separate headings, which should be short, descriptive, and optimized for search engines.
- `{{%/*  heading "nextSteps" */%}}`: (Optional) Link to related concepts, tasks, and/or tutorials. This heading is a Hugo shortcode that compiles to "Next steps".


## Reference

A Reference page contains the same frontmatter as other page types. The body format is less structured. Content is generally autogenerated material such as API and CLI references.

## Troubleshooting

A Troubleshooting page contains the same frontmatter as other page types. The body format is less structured. Be sure to list the exact error the reader could encounter and the solution.
