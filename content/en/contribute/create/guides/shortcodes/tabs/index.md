---
title: "Use the Custom Tabs Shortcode"
linkTitle: Tabs
no_list: true
description: >
  Examples of how to use the custom Tabs shortcode.
---

## Tabs - Docsy shortcode

Introduced in 2022. https://www.docsy.dev/docs/adding-content/shortcodes/#tabbed-panes

Tabbed panes with included files - **do not** use the Docsy `readfile` shortcode inside the Docsy tabbed pane shortcode! Markdown and HTML do not render correctly.

Examples of including markdown files using the armory/docs `include` shortcode. **Note** the delimiters!

### tab with %, include with %

```go-html-template
{{</* tabpane text=true right=true >}}
  {{< tab header="**Mode**:" disabled=true />}}
  {{% tab header="Cluster" text=true %}}
  {{% include "armory-operator/op-install-cluster.md" %}}
  {{% /tab %}}
  {{% tab header="Basic" text=true %}}
  {{% include  "armory-operator/op-install-basic.md" %}}
  {{% /tab %}}
{{< /tabpane */>}}
```
**RENDERED OUTPUT**

{{< tabpane text=true right=true >}}
  {{< tab header="**Mode**:" disabled=true />}}
  {{% tab header="Cluster" text=true %}}
  {{% include "armory-operator/op-install-cluster.md" %}}
  {{% /tab %}}
  {{% tab header="Basic" text=true %}}
  {{% include  "armory-operator/op-install-basic.md" %}}
  {{% /tab %}}
{{< /tabpane >}}

### tab with %,  include with <

```go-html-template
{{</* tabpane text=true right=true >}}
  {{< tab header="**Mode**:" disabled=true />}}
  {{% tab header="Cluster" text=true %}}
  {{< include "armory-operator/op-install-cluster.md" >}}
  {{% /tab %}}
  {{% tab header="Basic" text=true %}}
  {{< include "armory-operator/op-install-basic.md" >}}
  {{% /tab %}}
{{< /tabpane */>}}
```

**RENDERED OUTPUT**

{{< tabpane text=true right=true >}}
  {{< tab header="**Mode**:" disabled=true />}}
  {{% tab header="Cluster" text=true %}}
  {{< include "armory-operator/op-install-cluster.md" >}}
  {{% /tab %}}
  {{% tab header="Basic" text=true %}}
  {{< include "armory-operator/op-install-basic.md" >}}
  {{% /tab %}}
{{< /tabpane >}}

### tab with %, readfile with %

```go-html-template
{{</* tabpane text=true right=true >}}
  {{< tab header="**Mode**:" disabled=true />}}
  {{% tab header="Cluster" text=true %}}
  {{% readfile file="/includes/armory-operator/op-install-cluster.md" %}}
  {{% /tab %}}
  {{% tab header="Basic" text=true %}}
  {{% readfile file="/includes/armory-operator/op-install-basic.md" %}}
  {{% /tab %}}
{{< /tabpane */>}}
```
**RENDERED OUTPUT**

{{< tabpane text=true right=true >}}
  {{< tab header="**Mode**:" disabled=true />}}
  {{% tab header="Cluster" text=true %}}
  {{% readfile file="/includes/armory-operator/op-install-cluster.md" %}}
  {{% /tab %}}
  {{% tab header="Basic" text=true %}}
  {{% readfile file="/includes/armory-operator/op-install-basic.md" %}}
  {{% /tab %}}
{{< /tabpane >}}

### tab with %,  readfile with <

```go-html-template
{{</* tabpane text=true right=true >}}
  {{< tab header="**Mode**:" disabled=true />}}
  {{% tab header="Cluster" text=true %}}
  {{< readfile file="/includes/plugins/scale-agent/api-overview.md" >}}
  {{% /tab %}}
  {{% tab header="Basic" text=true %}}
  {{< readfile file="/includes/armory-operator/op-install-basic.md" >}}
  {{% /tab %}}
{{< /tabpane */>}}

```

**RENDERED OUTPUT**

{{< tabpane text=true right=true >}}
  {{< tab header="**Mode**:" disabled=true />}}
  {{% tab header="Cluster" text=true %}}
  {{< readfile "/includes/plugins/scale-agent/api-overview.md" >}}
  {{% /tab %}}
  {{% tab header="Basic" text=true %}}
  {{< readfile file="/includes/armory-operator/op-install-basic.md" >}}
  {{% /tab %}}
{{< /tabpane >}}



### Inserting raw HTML

`rawhtml`

Usage:

```md
## Heading
{{</* rawhtml */>}}
<p>
    This is <strong>raw HTML</strong>, inside Markdown.
  </p>
{{</* /rawhtml */>}}
```


{{< rawhtml >}}
<p>
    This is <strong>raw HTML</strong>, inside Markdown.
  </p>
{{< /rawhtml >}}  




