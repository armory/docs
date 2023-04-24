Armory's _Pipelines-as-Code_ feature provides a way to specify pipeline definitions in source code repos such as GitHub and BitBucket.

The Armory installation provides a service called _Dinghy_, which keeps the pipeline in sync with what is defined in the GitHub repo. Also, users are able to make a pipeline by composing other pipelines, stages, or tasks and templating certain values.

{{% include "note-github-branch-name.md" %}}