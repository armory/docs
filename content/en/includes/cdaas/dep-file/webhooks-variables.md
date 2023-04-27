---
---

**Armory Provided Context Variables**

Armory provides the following variables for every webhook execution. These are all prefixed with `armory` and are surrounded by `{{}}` when used. For example, to use `applicationName` variable that Armory supplies, you use the following snippet in the query template: `{{armory.applicationName}}`.

Armory provides the following variables:

| Variable                 | Annotation                          | Environment variable      | Notes                                                                       |
|--------------------------|-------------------------------------|---------------------------|-----------------------------------------------------------------------------|
| applicationName          | `deploy.armory.io/application`      | `ARMORY_APPLICATION_NAME` | Added as annotation resources and as environment variables on  pods*        |
| deploymentId             | `deploy.armory.io/deployment-id`    | `ARMORY_DEPLOYMENT_ID`    | Added as annotation resources and as environment variables on  pods*        |
| environmentName          | `deploy.armory.io/environment`      | `ARMORY_ENVIRONMENT_NAME` | Added as annotation resources and as environment variables on  pods*        |
| replicaSetName           | `deploy.armory.io/replica-set-name` | `ARMORY_REPLICA_SET_NAME` | Added as annotation resources and as environment variables on  pods*        |
| accountName              | -                                   | -                         | The name of the account (or agentIdentifier) used to execute the deployment |
| namespace                | -                                   | -                         | The namespace resources are being deployed to                               |
