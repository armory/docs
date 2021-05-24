---
title: "input.user"
linkTitle: "input.user"
description: "The `input.user` object is present in most packages."
---

This object provides information about the user performing the action. This can be used to restrict actions by role.

| Key                        | Type      | Description                                                                                                                                      |
| -------------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| `input.user.isAdmin`       | `boolean` | is the user who started this pipeline an admin user                                                                                              |
| `input.user.username`      | `string`  | what is the user ID of the user that started this pipeline.                                                                                      |
| `input.user.role[].name`   | `string`  | The names of the roles assigned to the user. This will only show up if FIAT is configured to provide roles.                                      |
| `input.user.role[].source` | `string`  | The source that granted the user this role. If you have multiple sources defining roles in fiat, this can be used to differentiate between them. |