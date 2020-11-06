---
title: "Using Shortcodes"
weight: 999
draft: true
---

## Hugo shortcodes

[Hugo Shortcodes Guide](https://gohugo.io/content-management/shortcodes/)

gist, youtube, figure, ref, relref and more

For how to use the `gist` shortcode, see {{< linkWithTitle "gist-vs-codeblock.md" >}} and {{< linkWithTitle "entire-gist.md" >}}

## Docsy theme shortcodes

[Docsy Shortcodes](https://www.docsy.dev/docs/adding-content/shortcodes/)

alert, swaggerui, imgproc

## Armory docs custom shortcodes

location:  `docs/layouts/shortcodes`

### Hyperlink with page title

You can use `linkWithTitle` to replace a markdown hyperlink.

```markdown
[page name]({{ < ref "file name" >}})

See the [Best Practices]({{</* ref "best-practices" */>}}) guide for ....

```

If you want to use the page's front matter title as the text of the hyperlink, you can use the `linkWithTitle` shortcode instead. It creates an HTML hyperlink using the page's title and `Permalink`.  Do not use this shortcode if you want to link to a specific section within a page.

```markdown

See the {{</* linkWithTitle best-practices.md */>}} page...
```

Renders as:

See the {{< linkWithTitle best-practices.md >}} page...

### Google suite shortcode

In your Google sheet, choose "Publish to web" and then copy the URL.

#### Sheet


{{< gsuite src="https://docs.google.com/spreadsheets/d/e/2PACX-1vT9PZ2yPxUYIxis4SfAN6ZMFn7haf6KrHQqmW97Co744Mz0dskmD2fIJsR5-kNYG7NOlOKz1SzXww7i/pubhtml?gid=0&amp;single=true&amp;widget=true&amp;headers=false" width="100%" height="100%" >}}


#### Slide deck

{{< gsuite src="https://docs.google.com/presentation/d/e/2PACX-1vQ7b90rHF2gS-4FUJWwuc8sK5JCb-fO-UupXqEZi-7eIdUBIcqTn2IEn0X9WSf0xucHlIVwPgovTQT5/embed?start=false&loop=false&delayms=3000" width="960" height="569" >}}

### Tabs
<!-- Copied from github.com/kubernetes/website project, which has a Creative Commons Attribution 4.0 International license -->

In a markdown page (`.md` file) on this site, you can add a tab set to display multiple flavors of a given solution.

The `tabs` shortcode takes these parameters:

* `name`: The name as shown on the tab.
* `codelang`: If you provide inner content to the `tab` shortcode, you can tell Hugo what code language to use for highlighting.
* `include`: The file to include in the tab. If the tab lives in a Hugo [leaf bundle](https://gohugo.io/content-management/page-bundles/#leaf-bundles), the file -- which can be any MIME type supported by Hugo -- is looked up in the bundle itself. If not, the content page that needs to be included is looked up relative to the current page. Note that with the `include`, you do not have any shortcode inner content and must use the self-closing syntax. For example, <code>{{</* tab name="Content File #1" include="example1" /*/>}}</code>. The language needs to be specified under `codelang` or the language is taken based on the file name. Non-content files are code-highlighted by default.
* If your inner content is markdown, you must use the `%`-delimiter to surround the tab. For example, `{{%/* tab name="Tab 1" %}}This is **markdown**{{% /tab */%}}`
* You can combine the variations mentioned above inside a tab set.

Below is a demo of the tabs shortcode.

{{% alert title="Warning" color="warning" %}}
The tab **name** in a `tabs` definition must be unique within a content page.
{{% /alert %}}

#### Tabs demo: Code highlighting

```go-text-template
{{</* tabs name="tab_with_code" >}}
{{{< tab name="Tab 1" codelang="bash" >}}
echo "This is tab 1."
{{< /tab >}}
{{< tab name="Tab 2" codelang="go" >}}
println "This is tab 2."
{{< /tab >}}}
{{< /tabs */>}}
```

Renders to:

{{< tabs name="tab_with_code" >}}
{{< tab name="Tab 1" codelang="bash" >}}
echo "This is tab 1."
{{< /tab >}}
{{< tab name="Tab 2" codelang="go" >}}
println "This is tab 2."
{{< /tab >}}
{{< /tabs >}}

#### Tabs demo: Inline Markdown and HTML

```go-html-template
{{</* tabs name="tab_with_md" >}}
{{% tab name="Markdown" %}}
This is **some markdown.**
{{% alert title="Warning" color="warning" %}}
It can even contain shortcodes.
{{% /alert %}}
{{% /tab %}}
{{< tab name="HTML" >}}
<div>
	<h3>Plain HTML</h3>
	<p>This is some <i>plain</i> HTML.</p>
</div>
{{< /tab >}}
{{< /tabs */>}}
```

Renders to:

{{< tabs name="tab_with_md" >}}
{{% tab name="Markdown" %}}
This is **some markdown.**

{{% alert title="Warning" color="warning" %}}
It can even contain shortcodes.
{{% /alert %}}

{{% /tab %}}
{{< tab name="HTML" >}}
<div>
	<h3>Plain HTML</h3>
	<p>This is some <i>plain</i> HTML.</p>
</div>
{{< /tab >}}
{{< /tabs >}}

#### Tabs demo: File include

```go-html-template
{{</* tabs name="tab_with_file_include" */>}}
{{</* tab name="Content File #1" include="example1" */>}}
{{</* tab name="Content File #2" include="example2" */>}}
{{</* tab name="JSON File" include="podtemplate" */>}}
{{</* /tabs */>}}
```

Renders to:

{{< tabs name="tab_with_file_include" >}}
{{< tab name="Content File #1" include="example1" />}}
{{< tab name="Content File #2" include="example2" />}}
{{< tab name="JSON File" include="podtemplate.json" />}}
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

See the {{< linkWithTitle pacrd-crd-docs.md >}} for an example.