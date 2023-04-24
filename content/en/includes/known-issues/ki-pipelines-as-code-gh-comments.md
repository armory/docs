### Pipelines-as-Code GitHub comments

There is a known issue where Pipelines-as-Code can generate hundreds of comments in a GitHub Pull Request (PR) when updates are made, such as when a module that is used by multiple `dinghyfiles` gets changed. These comments may prevent the GitHub UI from loading or related API calls may lead to rate limiting.

**Affected versions**: Armory CD 2.26.x and later

**Workaround**:

You can either manually resolve the comments so that you can merge any PRs or turn the notifications that Pipelines-as-Code sends to GitHub.

For information about about how to disable this functionality, see [GitHub Notifications]({{< ref "plugins/pipelines-as-code/install/configure#github-notifications" >}}).


