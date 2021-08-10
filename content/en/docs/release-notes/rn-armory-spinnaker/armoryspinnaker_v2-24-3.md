---
title: v2.24.3 Armory Release 
toc_hide: true
version: 02.24.02
description: >
  Release notes for Armory Enterprise v2.24.3
---

Filler page to get 2.24.3 things reviewed. As usual, Cameron will generate the file when ready

## AWS Lambda 

<!--https://github.com/spinnaker-plugins/aws-lambda-deployment-plugin-spinnaker/commit/7f7391855057daa34f03bd40796572eab2c9f51a#diff-b335630551682c19a781afebcf4d07bf978fb1f8ac04c6bf87428ed5106870f5 -->

> These improvements require version 1.0.8 of the AWS Lambda Plugin in addition to Armory Enterprise 2.24.3.

This release includes the following new features and improvements for the Lambda provider:

* Improved cache performance including fixes to cache issues found in 2.24.2
* New configuration properties that give you greater control over how Armory Enterprise behaves when connection or cache issues occur.

Configure the following properties in your Operator manifest (`spinnakerservice.yml` by default). Note that all these properties are optional and use the default if omitted. 

`spec.spinnakerConfig.profiles.orca.spinnaker.`:

- `cloudDriverReadTimeout`: Integer. The timeout (in seconds) when attempting to read from Lambda. (Defaults to 60 seconds.)
- `cloudDriverConnectTimeout`: Integer. The connection timeout (in seconds) when trying to connect to AWS Lambda from Clouddriver. (Defaults to 15 seconds.)
- `cacheRefreshRetryWaitTime`: Integer. The time (in seconds) to wait between retries when attempting to refresh the Lambda cache stored in Clouddriver. (Defaults to 15 seconds.)
- `cacheOnDemandRetryWaitTime`: Integer. The time (in seconds) to wait between retries when attempting to refresh the cache on-demand. (Defaults to 15 seconds.)

For example:

```yaml
# This example only shows the location of the properties. The rest of the manifest is omitted for brevity.
spec:
  spinnakerConfig:
    profiles:
      orca:
        lambdaPluginConfig:
          cloudDriverReadTimeout: 30
          cloudDriverConnectTimeout: 10
          cacheRefreshRetryWaitTime: 10
          CacheOnDemandRetryWaitTime: 10
```

`spec.spinnakerConfig.profiles.clouddriver.aws.lambda.`:

- `retry.timeout`: Integer. The time (in minutes) that Clouddriver will wait before timing out when attempting to connect to the Lambda client. (Defaults to 15 minutes.)
- `concurrency.threads`: Integer. The maximum number of threads to use for calls to the Lambda client. (Defaults to 10 threads.) At a minimum, Armory recommends setting the number of threads to double the rate limit. For information about rate limits, see [Fine-grained rate limits]({{< ref "rate-limit#fine-grained-rate-limits" >}}).

For example:

```yaml
# This example only shows the location of the properties. The rest of the manifest is omitted for brevity.
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        aws:
          enabled: true
          lambda:
            enabled: true
            retry:              
              timeout: 10  
            concurrency:                   
              threads: 5  
```