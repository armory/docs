### ManifestForceCacheRefreshTask removed from Orca

When you upgrade to 2.23.0 or later, you might encounter the following error:

```bash
2021-01-29 23:57:19.691 ERROR 1 --- [    scheduler-2] c.netflix.spinnaker.q.redis.RedisQueue   : Failed to read message 8f072714f1df6dbf3af93a4f4fe4cae2, requeuing...
com.fasterxml.jackson.databind.JsonMappingException: No task found for 'com.netflix.spinnaker.orca.clouddriver.tasks.manifest.ManifestForceCacheRefreshTask' (through reference chain: com.netflix.spinnaker.orca.q.RunTask["taskType"])
```

The `ManifestForceCacheRefreshTask` task is no longer a required task when deploying a manifest. In earlier releases, forcing the cache to refresh was part of the deployment process for manifests. Because of this change, if a task was running or retried before the upgrade, the error shows up in logs as an exception.

**Workaround**

Before starting, make sure that you have access to the Redis instance that Orca uses.

To resolve this issue, delete the message from the queue:

1. Verify that there are pipeline execution failure messages that contain `ManifestForceCacheRefreshTask`:

   **Redis**
   ```bash
   hgetall orca.task.queue.messages
   ```
   
   The command returns information similar to the following:
   
   ```
   1) "93ac65e03399a4cfd3678e1355936ab2"
   2) "{\"kind\":\"runTask\",\"executionType\":\"PIPELINE\",\"executionId\":\"01EVFCCDG3Q2209E0Z1QTNC0FS\",   \"application\":\"armoryhellodeploy\",\"stageId\":\"01EVFCCDG3TJ7AFPYEJT1N8RDJ\",\"taskId\":\"5\",\"taskType\":\"com.netflix.spinnaker.   orca.clouddriver.tasks.manifest.ManifestForceCacheRefreshTask\",\"attributes\":[{\"kind\":\"attempts\",\"attempts\":1}],   \"ackTimeoutMs\":600000}"

2. Delete the message(s):

   **Redis**
   ```bash
   hdel orca.task.queue.messages 
   ```

   The command returns information similar to the following:

   ```
   93ac65e03399a4cfd3678e1355936ab2
   (integer) 1
   ```
