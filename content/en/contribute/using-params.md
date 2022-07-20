---
title: "Using Parameters"
draft: true
description: >
  Add a parameter to `config.toml` and then use it in Markdown pages.
---

You can add a new global parameter to `config.toml` in the `[params]` section.

You use the Hugo `param` shortcode to display the value of the parameter.


```markdown

The latest Armory version is {{</* param armory-version */>}}.
```

Renders as:

The latest Armory version is {{< param armory-version >}}.


You can use the `param` shortcode inside codeblock as well.

```markdown
latestSpinnaker: {{</* param armory-version */>}}
versions:
- version: {{</* param armory-version */>}}
  alias: OSS Release <ossVersion> # The corresponding OSS version can be found in the Release Notes
  changelog: <Link to Armory Release Notes for this version>
  lastUpdate: "1568853000000"
```

Renders as:

```yaml
latestSpinnaker: {{< param armory-version >}}
versions:
- version: {{< param armory-version >}}
  alias: OSS Release <ossVersion> # The corresponding OSS version can be found in the Release Notes
  changelog: <Link to Armory Release Notes for this version>
  lastUpdate: "1568853000000"
```
