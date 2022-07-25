---
title: "Create a New Page"
description: >
  How to create a new page.
---

## Page frontmatter

Each page must contain [frontmatter](https://www.docsy.dev/docs/adding-content/content/#page-frontmatter) at the top of the page.

```
---
title: Armory Continuous Deployment-as-a-Service Architecture
linkTitle: Architecture
weight: 10
description: >
  Armory Continuous Deployment-as-a-Service Architecture
---
```

* **title**: (Required) The title of your page
* **linkTitle**: (Optional) A shorter version of the page title; this appears in the site navigation menu.
* **weight**: (Optional) Non-zero integer; the weight determines the order in which the page appears in the site navigation menu. A lower weight gets higher precedence.
* **description**: (Optional) A description of your page; this appears in search engine results.

## Page organization

Divide your page into sections using headings.

The top-level heading starts with `##`. Create subheadings by adding a `#` to each lower level heading. For example:

```markdown
## Top-level heading
### Second-level heading starts with three pound signs
#### Third-level heading
##### Fourth-level heading
```

Try to keep your headings at `####` or above. If you have to use 
## Page content types



### Concept

A concept page explains an aspect of the system. The content is objective, containing architecture, definitions, rules, and guidelines. Rather than containing a sequence of steps, a content page link to related tasks and tutorials.



### Task


### Tutorial



## How to create a new page


1. Create a new branch for your new page. See {{< linkWithTitle "local-clone.md" >}}
1. Decide which directory your new page should go into. If you need to create a new section, be sure to include the `_index.md` file, which functions as the section's landing page. See the Docsy [docs](https://www.docsy.dev/docs/adding-content/content/#docs-section-landing-pages) for details.
1. Create a blank markdown file or copy an existing one. Either way, you’ll need to create or update the [frontmatter](https://www.docsy.dev/docs/adding-content/content/#page-frontmatter), which is the metadata that appears between the `---` at the top of a file .
1. Pay special attention to `weight` in the front matter. It determines where a page shows up in the left nav for its section. 
