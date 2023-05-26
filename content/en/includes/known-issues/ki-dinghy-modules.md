
#### Pipelines-as-Code fails unexpectedly when updating modules
<!--BOB-30145 -->
The container for the Dinghy service that Pipelines-as-Code uses fails when updating pipelines using modules stored in GitHub. The error you encounter references a failure related to GitHub, such as one of the following:

```
422 Validation Failed [{Resource:CommitComment Field:body Code:custom Message:body is too long (maximum is 65536 characters)}]
```

or

```
422 No commit found for SHA: <SHA for a commit> []
```

This results in only some pipelines in your deployment getting updated when a module gets updated.

**Workaround**: 

1. Use the `arm CLI` to render the JSON for your `dinghyfiles`.
2. Update pipelines manually using the UI.

**Affected versions**: 2.22.x, 2.23.x, 2.24.0
**Fixed versions**: 2.25.0

