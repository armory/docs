---
title: File-with-Tabs #1

---

This is an **example** content file inside the leaf bundle.

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