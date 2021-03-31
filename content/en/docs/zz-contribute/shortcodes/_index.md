---
title: "Using Shortcodes"
weight: 999
draft: true
---

## Hugo shortcodes

[Hugo Shortcodes Guide](https://gohugo.io/content-management/shortcodes/)

gist, youtube, figure, ref, relref and more

For how to use the `gist` shortcode, see {{< linkWithTitle "gist-vs-codeblock.md" >}} and {{< linkWithTitle "entire-gist.md" >}}.

## Docsy theme shortcodes

[Docsy Shortcodes](https://www.docsy.dev/docs/adding-content/shortcodes/)

alert, swaggerui, imgproc

## Armory docs custom shortcodes

location:  `docs/layouts/shortcodes`

## Heading
This shortcode works in conjunction with the `i118n/en.toml` file, which contains key/value pairs for common headings.

Usage:

```markdown
#### {{%/* heading "prereq" */%}}
```

Renders:

#### {{% heading "prereq" %}}

Another example:

```markdown
#### {{%/* heading "installOperator" */%}}
```

#### {{% heading "installOperator" %}}

### Hyperlink with page title

You can use `linkWithTitle` to replace a markdown hyperlink.

```markdown
[page name]({{ < ref "file name" >}})

See the [Best Practices]({{</* ref "best-practices" */>}}) guide for ....

```

If you want to use the page's front matter title as the text of the hyperlink, you can use the `linkWithTitle` shortcode instead. It creates an HTML hyperlink using the page's title and `Permalink`.  Do not use this shortcode if you want to link to a specific section within a page.

```markdown

See the {{</* linkWithTitle best-practices.md */>}} page...

Look at this page: {{</* linkWithTitle best-practices.md */>}}.
```

Renders as:

See the {{< linkWithTitle best-practices.md >}} page...

See this page: {{< linkWithTitle agent-troubleshooting.md >}}.

### Google suite shortcode

In your Google sheet, choose "Publish to web" and then copy the URL.

#### Sheet


{{< gsuite src="https://docs.google.com/spreadsheets/d/e/2PACX-1vT9PZ2yPxUYIxis4SfAN6ZMFn7haf6KrHQqmW97Co744Mz0dskmD2fIJsR5-kNYG7NOlOKz1SzXww7i/pubhtml?gid=0&amp;single=true&amp;widget=true&amp;headers=false" width="100%" height="100%" >}}


#### Slide deck

{{< gsuite src="https://docs.google.com/presentation/d/e/2PACX-1vQ7b90rHF2gS-4FUJWwuc8sK5JCb-fO-UupXqEZi-7eIdUBIcqTn2IEn0X9WSf0xucHlIVwPgovTQT5/embed?start=false&loop=false&delayms=3000" width="960" height="569" >}}

## Icons

Search for icons at [Font Awesome](https://fontawesome.com/icons/)

```md
1. Click **{{</* icon "play" */>}} Start Manual Execution**.
```

Renders to:

1. Click **{{< icon "play" >}} Start Manual Execution**.