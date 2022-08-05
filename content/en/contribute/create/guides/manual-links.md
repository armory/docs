---
title: "Create Page Link in Front Matter"
description: >
   Use a `manualLink` in a page's frontmatter to automatically redirect to another page.
---

## Hyperlink to external site

```markdown
---
title: "Manual Hyperlink Example"
manualLink: "https://www.docsy.dev/docs/adding-content/navigation/#add-manual-links-to-the-section-menu"
manualLinkTarget: "_blank"
description: >
  Manual hyperlink example for a TOC entry  
---
```

Example of how to configure a manual link as a TOC item:

https://www.docsy.dev/docs/adding-content/navigation/#add-manual-links-to-the-section-menu


## Hyperlink to internal page

```markdown
---
title: "Manual Internal Link Example"
manualLinkRelRef: "using-params.md"
manualLinkTarget: "_blank"
description: >
  Manual hyperlink example for a TOC entry  
---
```

