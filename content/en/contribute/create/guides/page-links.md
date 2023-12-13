---
title: How to Link to Internal Pages
linkTitle: Link to Internal Pages
description: >
  Learn how to use shortcodes to link to other internal pages.
---

## How to link to other pages in the docs

Hugo has two useful shortcodes, `ref` and `relref`, for linking to other pages within the docs. Additionally, the docs has custom shortcodes that create links with either the page's `title` or `linkTitle`.

{{% alert color="warning" title="DO NOT HARDCODE PATHS" %}}

Hugo doesn't detect broken links when you hardcode the path to an internal page.

When you use a shortcode, Hugo **does** throw a compile error when page's path is incorrect (typo, changed page name, moved the page's location, etc).

**DO NOT**

```markdown
See [Create a Terraform Integration stage](/plugins/terraform/use/#create-a-terraform-integration-stage)
 ```

**DO**

```markdown
See [Create a Terraform Integration stage]({{</* ref "plugins/terraform/use#create-a-terraform-integration-stage" */>}})
```

{{% /alert %}}

### `ref`

`ref` relies on unique file names. If the filename is not unique, you must use include the path.

Examples:

```markdown
[Overview - Load Balancers]({{</* ref "load-balancers" */>}})

[SpinnakerService manifest sections]({{</* ref "op-config-manifest#manifest-sections"  */>}})

Because there are many files named `release-notes.md`, include the path:

See the Policy Engine [release notes]({{</* ref "plugins/policy-engine/release-notes" */>}}).
```

Renders to:

[Overview - Load Balancers]({{< ref "load-balancers" >}})

[SpinnakerService  manifest sections]({{< ref "continuous-deployment/installation/armory-operator/op-config-manifest#manifest-sections"  >}})

See the Policy Engine [release notes]({{< ref "plugins/policy-engine/release-notes" >}}).



Reference:

- [Hugo `ref` docs](https://gohugo.io/content-management/shortcodes/#ref-and-relref)
- [Hugo Links and cross references](https://gohugo.io/content-management/cross-references/)

### `relref`

The second is `relref`, which **requires** the complete path to the file. 

```markdown
[Overview - Load Balancers]({{</* relref "/continuous-deployment/overview/load-balancers" */>}})
```

Renders to:

[Overview - Load Balancers]({{< relref "/continuous-deployment/overview/load-balancers" >}})

Reference:

* [Hugo `relref` docs](https://gohugo.io/content-management/shortcodes/#ref-and-relref)
* [Hugo Links and cross references](https://gohugo.io/content-management/cross-references/)

### `linkWithTitle`

Another option is our custom `linkWithTitle` shortcode, which displays the page's title as the link text. You can find the code in `docs/layouts/shortcodes/linkWithTitle.html`.

```markdown
* See the {{</* linkWithTitle "artifacts-ecr-connect.md" */>}} guide for details.
* See {{</* linkWithTitle "plugins/github-integration/authz.md" */>}}.
```

Renders to:

* See the {{< linkWithTitle "artifacts-ecr-connect.md" >}} guide for details.
* See {{< linkWithTitle "plugins/github-integration/authz.md" >}} for more information.

### `linkWithLinkTitle`

`linkWithLinkTitle` displays the page's `linkTitle` as the link text. You can find the code in `docs/layouts/shortcodes/linkWithLinkTitle.html`.

Using the pages from the linkWithTitle section above:

```markdown
* See the {{</* linkWithLinkTitle "artifacts-ecr-connect.md" */>}} guide for details.
* See {{</* linkWithLinkTitle "plugins/github-integration/authz.md" */>}}.
```

Renders to:

* See the {{< linkWithLinkTitle "artifacts-ecr-connect.md" >}} guide for details.
* See {{< linkWithLinkTitle "plugins/github-integration/authz.md" >}} for more information.