---
title: "Prism Customization"
---

In order to extend and update our implementation of Prism, we override the version packaged with Docsy.

## Updating and Extending Prism

1. The [Docsy docs](https://www.docsy.dev/docs/adding-content/lookandfeel/#code-highlighting-with-prism) include a link to download their selection of syntaxes and plugins. To update, use that link, then add our custom additions via their checkbox.

1. Once everything is checked, the JS and CSS files can be downloaded or copied into their respective paths:

    - `static/js/prism.js`
    - `static/css/prism.css`

### Current add-on languages

None

### Current add-on themes

None

### Current add-on plugins

 - [Line Highlight](https://prismjs.com/plugins/line-highlight/)

## CSS customizations

Until an automated process is figured out, we much manually apply our custom css directly to `static/css/prism.css` after updating the Prism bundle.

### Font family

In the `pre[class*="language-"]` block, update the font-family to "Rubik":

{{< prism lang=css line=5 >}}
pre[class*="language-"] {
	color: black;
	background: none;
	text-shadow: 0 1px white;
	font-family: Rubik;
	font-size: 1em;
	text-align: left;
	white-space: pre;
	word-spacing: normal;
	word-break: normal;
	word-wrap: normal;
	line-height: 1.5;
{{< /prism >}}

### Line highlights

In the `.line-highlight` block, update the `linear gradient` section:

{{< prism lang=css line=9 >}}
.line-highlight {
	position: absolute;
	left: 0;
	right: 0;
	padding: inherit 0;
	margin-top: 1em; /* Same as .prism’s padding-top */

	background: hsla(24, 20%, 50%,.08);
	background: linear-gradient(to right, rgba(243, 239, 6, 0.418) 1%, hsla(24, 20%, 50%,.1));

	pointer-events: none;

	line-height: inherit;
	white-space: pre;
}
{{< /prism >}}
