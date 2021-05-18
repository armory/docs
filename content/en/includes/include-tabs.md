Tabs in an included file:

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