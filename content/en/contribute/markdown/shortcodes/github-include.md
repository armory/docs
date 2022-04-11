---
title: "Include Content of GitHub File"
exclude_search: true
---

## Include the contents of a file from a public GitHub repo

This shortcode is from https://github.com/haideralipunjabi/hugo-shortcodes/tree/master/github

## Usage  

``` hugo
{{</*   github repo="username/repo-name" file="/path/to/file" lang="language" options="highlight-options"  */>}}
```

*[Options Reference](https://gohugo.io/content-management/syntax-highlighting/#highlight-shortcode)*  
*[Language Reference](https://gohugo.io/content-management/syntax-highlighting/#list-of-chroma-highlighting-languages)*  

## `spinnakerservice.yml` from public `armory/spinnaker-operator`

```hugo
{{</* github repo="armory/spinnaker-operator" file="/deploy/spinnaker/complete/spinnakerservice.yml" lang="yaml" options=""  */>}}
```

{{< github repo="armory/spinnaker-operator" file="/deploy/spinnaker/complete/spinnakerservice.yml" lang="yaml" options="" >}}


## `spinnakerservice.yml` from private `armory-io/spinnaker-operator`

```hugo
{{</* github repo="armory-io/spinnaker-operator" file="/deploy/spinnaker/basic/SpinnakerService.yml" lang="yaml" options="" */>}}
```

{{< github repo="armory-io/spinnaker-operator" file="/deploy/spinnaker/basic/SpinnakerService.yml" lang="yaml" options="" >}}


## surround with collapsible panel

<details><summary>Expand to see file</summary>

{{< github repo="armory-io/spinnaker-operator" file="/deploy/spinnaker/basic/SpinnakerService.yml" lang="yaml" options="linenos=table" >}}
</details>


<details><summary>Show me the manifest</summary>

{{< github repo="armory/spinnaker-kustomize-patches" file="/armory/patch-policy-engine-plugin.yml" lang="yaml" options="" >}}
</details>

