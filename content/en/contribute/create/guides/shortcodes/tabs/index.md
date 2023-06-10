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
  {{% include "armory-operator/armory-op-install-cluster.md" %}}
  {{% /tab %}}
  {{% tab header="Basic" text=true %}}
  {{% include  "armory-operator/armory-op-install-basic.md" %}}
  {{% /tab %}}
{{< /tabpane */>}}
```
**RENDERED OUTPUT** 

{{< tabpane text=true right=true >}}
  {{< tab header="**Mode**:" disabled=true />}}
  {{% tab header="Cluster" text=true %}}
  {{% include "armory-operator/armory-op-install-cluster.md" %}}
  {{% /tab %}}
  {{% tab header="Basic" text=true %}}
  {{% include  "armory-operator/armory-op-install-basic.md" %}}
  {{% /tab %}}
{{< /tabpane >}}

### tab with %,  include with <

```go-html-template
{{</* tabpane text=true right=true >}}
  {{< tab header="**Mode**:" disabled=true />}}
  {{% tab header="Cluster" text=true %}}
  {{< include "armory-operator/armory-op-install-cluster.md" >}}
  {{% /tab %}}
  {{% tab header="Basic" text=true %}}
  {{< include "armory-operator/armory-op-install-basic.md" >}}
  {{% /tab %}}
{{< /tabpane */>}}

```

**RENDERED OUTPUT** 

{{< tabpane text=true right=true >}}
  {{< tab header="**Mode**:" disabled=true />}}
  {{% tab header="Cluster" text=true %}}
  {{< include "armory-operator/armory-op-install-cluster.md" >}}
  {{% /tab %}}
  {{% tab header="Basic" text=true %}}
  {{< include "armory-operator/armory-op-install-basic.md" >}}
  {{% /tab %}}
{{< /tabpane >}}

### tab with %, readfile with %

```go-html-template
{{</* tabpane text=true right=true >}}
  {{< tab header="**Mode**:" disabled=true />}}
  {{% tab header="Cluster" text=true %}}
  {{% readfile file="/includes/armory-operator/armory-op-install-cluster.md" %}}
  {{% /tab %}}
  {{% tab header="Basic" text=true %}}
  {{% readfile file="/includes/armory-operator/armory-op-install-basic.md" %}}
  {{% /tab %}}
{{< /tabpane */>}}
```
**RENDERED OUTPUT** 

{{< tabpane text=true right=true >}}
  {{< tab header="**Mode**:" disabled=true />}}
  {{% tab header="Cluster" text=true %}}
  {{% readfile file="/includes/armory-operator/armory-op-install-cluster.md" %}}
  {{% /tab %}}
  {{% tab header="Basic" text=true %}}
  {{% readfile file="/includes/armory-operator/armory-op-install-basic.md" %}}
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
  {{< readfile file="/includes/armory-operator/armory-op-install-basic.md" >}}
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
  {{< readfile file="/includes/armory-operator/armory-op-install-basic.md" >}}
  {{% /tab %}}
{{< /tabpane >}}


## Tabs - custom armory/docs shortcode
<!-- Copied from github.com/kubernetes/website project, which has a Creative Commons Attribution 4.0 International license -->

>This is not the same as the Tabs shortcode included with Docsy (which was created after Armory added its own Tabs shortcode).

In a markdown page (`.md` file) on this site, you can add a tab set to display multiple flavors of a given solution.

The `tabs` shortcode takes these parameters:

* `name`: The name as shown on the tab.
* `codelang`: If you provide inner content to the `tab` shortcode, you can tell Hugo what code language to use for highlighting.
* `include`: The file to include in the tab. If the tab lives in a Hugo [leaf bundle](https://gohugo.io/content-management/page-bundles/#leaf-bundles), the file -- which can be any MIME type supported by Hugo -- is looked up in the bundle itself. If not, the content page that needs to be included is looked up relative to the current page. Note that with the `include`, you do not have any shortcode inner content and must use the self-closing syntax. For example, <code>{{</* tab name="Content File #1" include="example1" /*/>}}</code>. The language needs to be specified under `codelang` or the language is taken based on the file name. Non-content files are code-highlighted by default.
* If your inner content is markdown, you must use the `%`-delimiter to surround the tab. For example, `{{%/* tab name="Tab 1" %}}This is **markdown**{{% /tabbody */%}}`
* You can combine the variations mentioned above inside a tab set.

Below is a demo of the tabs shortcode.

{{% alert title="Warning" color="warning" %}}
The tab **name** in a `tabs` definition must be unique within a content page.
{{% /alert %}}

### Tabs demo: Code highlighting

```go-text-template
{{</* tabs name="tab_with_code" >}}
{{{< tabbody name="Tab 1" codelang="bash" >}}
echo "This is tab 1."
{{< /tabbody >}}
{{< tabbody name="Tab 2" codelang="go" >}}
println "This is tabbody 2."
{{< /tabbody >}}}
{{< /tabs */>}}
```

Renders to:

{{< tabs name="tab_with_code" >}}
{{< tabbody name="Tab 1" codelang="bash" >}}
echo "This is tabbody 1."
{{< /tabbody >}}
{{< tabbody name="Tab 2" codelang="go" >}}
println "This is tabbody 2."
{{< /tabbody >}}
{{< /tabs >}}

### Tabs demo: Inline Markdown and HTML

```go-html-template
{{</* tabs name="tab_with_md" >}}
{{% tabbody name="Markdown" %}}
This is **some markdown.**
{{% alert title="Warning" color="warning" %}}
It can even contain shortcodes.
{{% /alert %}}
{{% /tabbody %}}
{{< tabbody name="HTML" >}}
<div>
	<h3>Plain HTML</h3>
	<p>This is some <i>plain</i> HTML.</p>
</div>
{{< /tabbody >}}
{{< /tabs */>}}
```

Renders to:

{{< tabs name="tab_with_md" >}}
{{% tabbody name="Markdown" %}}
This is **some markdown.**

{{% alert title="Warning" color="warning" %}}
It can even contain shortcodes.
{{% /alert %}}

{{% /tabbody %}}
{{< tabbody name="HTML" >}}
<div>
	<h3>Plain HTML</h3>
	<p>This is some <i>plain</i> HTML.</p>
</div>
{{< /tabbody >}}
{{< /tabs >}}

### Tabs demo: File include

```go-html-template
{{</* tabs name="tab_with_file_include" */>}}
{{</* tabbody name="Content File #1" include="example1" */>}}
{{</* tabbody name="Content File #2" include="example2" */>}}
{{</* tabbody name="JSON File" include="podtemplate" */>}}
{{</* /tabs */>}}
```

Renders to:

{{< tabs name="tab_with_file_include" >}}
{{< tabbody name="Content File #1" include="example1" />}}
{{< tabbody name="Content File #2" include="example2" />}}
{{< tabbody name="JSON File" include="podtemplate.json" />}}
{{< /tabs >}}


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


### Includes with tabs

Hugo doesn't render the tabs shortcodes when they are embedded in file in the `includes` directory.

>**This examples is supposed to render incorrectly**

```
{{%/* include "include-tabs.md" */%}}
```

{{% include "include-tabs.md" %}}


### Tabs in a file in the leaf bundle

>**This examples is supposed to render incorrectly**

```
{{</* tabs name="tab_with_file_include2" */>}}
{{</* tabbody name="Content File #1" include="example1" */>}}
{{</* /tabbody */>}}
{{</* tabbody name="Content File #2" include="example2" */>}}
{{</* /tabbody */>}}
{{</*tabbody name="JSON File" include="podtemplate.json" */>}}
{{</* /tabbody */>}}
{{</* tabbody name="File with Tabs" include="file-with-tabs.md" */>}}
{{</* /tabbody */>}}
{{</* /tabs */>}}
```

{{< tabs name="tab_with_file_include2" >}}
{{< tabbody name="Content File #1" include="example1" />}}
{{< tabbody name="Content File #2" include="example2" />}}
{{< tabbody name="JSON File" include="podtemplate.json" />}}
{{< tabbody name="File with Tabs" include="file-with-tabs.md" />}}
{{< /tabs >}}


### Tabs in a partial

>**This examples is supposed to render incorrectly**

```
{{/* partial "operator/op-install.html" . */}}
```

{{ partial "operator/op-install.html" . }}

</br></br>
</br></br>
</br></br>


