---
title: spinnaker.http.authz.tasks
linkTitle: tasks
---
Posts to the tasks api create new tasks in spinnaker. The following rego function can be leveraged in any task in order to determine what task type is being created:
```rego

    createsTaskOfType(tasktype){
        input.method="POST"
        input.path=["tasks"]
        input.body.job[_].type=tasktype
    }
```
