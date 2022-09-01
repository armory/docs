---
title: "Create a New Page"
weight: 10
description: >
  Learn how to create a new page.
---

## How to create a new page

1. Create a new branch for your new page. See {{< linkWithTitle "local-clone.md" >}}.
1. Decide what type of content your new page will be. See the {{< linkWithTitle "content-guide.md" >}} for details and structure.
1. Decide which directory your new page should go into. If you need to create a new section, be sure to include the `_index.md` file, which functions as the section's landing page. See the Docsy [docs](https://www.docsy.dev/docs/adding-content/content/#docs-section-landing-pages) for details.
1. Create a blank markdown file or copy an existing one of the same content type.
   - Pay special attention to `weight` in the front matter. It determines where a page shows up in the left nav for its section. If there isn't a weight OR if multiple pages in a section have the same weight, the default is to display alphabetically.
1. Add your content following the {{< linkWithTitle "docs-style-guide.md" >}} and then create a pull request as outlined in  {{< linkWithTitle "local-clone.md" >}}.
