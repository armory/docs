---
title: "input.user"
linkTitle: "input.user"
description: "The `input.user` object is present in most packages. This object provides information about the user performing the action. This can be used to restrict actions by role."
---

The following function can be used in your policies to determine if a user has a particular role assigned to it:

{{< prism lang="rego" line-numbers="true" >}}
hasRole(role){
    input.user.roles[_].name=role
}
{{< /prism >}}

| Key                        | Type      | Description                                                                                                                                      |
| -------------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| `input.user.isAdmin`       | `boolean` | Is the user who started this pipeline an admin user                                                                                              |
| `input.user.username`      | `string`  | What is the user ID of the user that started this pipeline.                                                                                      |
| `input.user.role[]`   | `string`  | The names of the roles assigned to the user. This only shows up if FIAT is configured to provide roles.                                          |
