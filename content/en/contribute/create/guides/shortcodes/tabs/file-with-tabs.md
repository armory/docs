---
title: File-with-Tabs #1

---

This is an **example** content file inside the leaf bundle.

{{< tabpane text=true right=true >}}
{{% tab header="Markdown" %}}
This is **some markdown.**

{{% alert title="Warning" color="warning" %}}
It can even contain shortcodes.
{{% /alert %}}

{{% /tab %}}
{{< tab header="HTML" >}}
<div>
	<h3>Plain HTML</h3>
	<p>This is some <i>plain</i> HTML.</p>
</div>
{{< /tab >}}
{{< /tabpane >}}