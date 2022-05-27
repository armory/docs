---
title: IAM Authentication Plugin
toc_hide: true
exclude_search: true
description: >
  The IAM Authentication Plugin allows Armory Enterprise to achieve MySQL connection for Orca, Clouddriver and Front50 services to AWS IAM to RDS Aurora Database.
---
![Proprietary](/images/proprietary.svg)
## Overview

Authenticates MySQL(Aurora) with RDS IAM-auth for Clouddriver, Orca, and Front50 services.

The plugin can read AWS credentials information from the plugin properties:

```yaml
armory:
  iam-auth:
    awsAccessKeyId: encrypted:k8s!n:spin-secrets!k:awsAccessKeyId # Your AWS Access Key ID. If not provided, the plugin will try to find AWS credentials as described at http://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/credentials.html#credentials-default
    secretAccessKey: encrypted:k8s!n:spin-secrets!k:secretAccessKey # Your AWS Secret Key. If not provided, the plugin will try to find AWS credentials as described at http://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/credentials.html#credentials-default
    region: us-west-2
```

The plugin can read the SQL connection information for `orca`, `clouddriver`, and `front50` services from the SQL properties configuration:

```yaml
sql:
  enabled: true
  connectionPools:
    default:
      # additional connection pool parameters are available here,
      # for more detail and to view defaults, see:
      # https://github.com/spinnaker/kork/blob/master/kork-sql/src/main/kotlin/com/netflix/spinnaker/kork/sql/config/ConnectionPoolProperties.kt
      default: true
      user: <USER>_service
      jdbcUrl: jdbc:mysql:aws://<RDSHOST>:<PORT>/<DATABASE>?acceptAwsProtocolOnly=true&useAwsIam=true
  migration:
    user: <USER>_migrate
    jdbcUrl: jdbc:mysql:aws://<RDSHOST>:<PORT>/<DATABASE>?acceptAwsProtocolOnly=true&useAwsIam=true

```

## Compatibility

| Min. version           | Notes                                   |
|------------------------|-----------------------------------------|
| Armory 2.27.2          |                                         |
| MySQL 5.7              | AWS RDS Aurora                          |

> The plugin is not actively tested in all compatible versions with all variants but is expected to work in the above.

## IAM Authentication Plugin Configuration

Make sure you meet the following prerequisites:
- Your MySQL Aurora cluster/instance has the **IAM Database Authentication** enabled. For further details on how to enable IAM Database Authentication, please refer to the [Enabling and disabling IAM database authentication documentation](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.Enabling.html).
- The database users you are using for the `orca`, `clouddriver`, and `front50` services exist in AWS IAM and have the right permissions to access your RDS Aurora cluster/instance. For further details on how to configure the database users' permissions on IAM, please refer to the [Creating and using an IAM policy for IAM database access documentation](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.DBAccounts.html).
- The database users you are using for the `orca`, `clouddriver`, and `front50` services have the **AWSAuthenticationPlugin** enabled and have the right permissions in their corresponding database. For further details on how to enable the AWSAuthenticationPlugin, please refer to the [Creating a database account using IAM authentication documentation](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.DBAccounts.html). For more information on the permissions required for the `orca`, `clouddriver`, and `front50` users over the database, please refer to [Configure Spinnaker's Orca Service to Use SQL RDBMS documentation](https://docs.armory.io/armory-enterprise/armory-admin/orca-sql-configure), [Configure Clouddriver to use a SQL Database documentation](https://docs.armory.io/armory-enterprise/armory-admin/clouddriver-sql-configure/), and [Set up Front50 to use SQL documentation](https://spinnaker.io/docs/setup/productionize/persistence/front50-sql/).
- The `orca`, `clouddriver`, and `front50` databases schema meet the requirements from the preceding references.

Example configuration using the Spinnaker Operator for `clouddriver` service:

```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      spinnaker:
        armory:
          iam-auth:
            awsAccessKeyId: encrypted:k8s!n:spin-secrets!k:awsAccessKeyId # Your AWS Access Key ID. If not provided, the plugin will try to find AWS credentials as described at http://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/credentials.html#credentials-default
            secretAccessKey: encrypted:k8s!n:spin-secrets!k:secretAccessKey # Your AWS Secret Key. If not provided, the plugin will try to find AWS credentials as described at http://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/credentials.html#credentials-default
            region: us-west-2

      clouddriver:
        spinnaker:
          extensibility:
            plugins:
              Armory.IAM:
                enabled: true
            repositories:
              iamPlugin:
                enabled: true
                # The init container will install plugins.json to this path.
                url: file:///opt/spinnaker/lib/local-plugins/iam/plugins.json
        sql:
          enabled: true
          taskRepository:
            enabled: true
          cache:
            enabled: true
            readBatchSize: 500
            writeBatchSize: 300
          scheduler:
            enabled: true # Disabled for Google CloudSQL and Amazon Managed RDS SQL https://spinnaker.io/setup/productionize/persistence/clouddriver-sql/#agent-scheduling
          connectionPools:
            default:
              # Additional connection pool parameters are available here,
              # for more detail and to view defaults, see:
              # https://github.com/spinnaker/kork/blob/master/kork-sql/src/main/kotlin/com/netflix/spinnaker/kork/sql/config/ConnectionPoolProperties.kt
              default: true
              user: clouddriver_service
              jdbcUrl: jdbc:mysql:aws://<RDSHOST>:<PORT>/clouddriver?acceptAwsProtocolOnly=true&useAwsIam=true
          migration:
            user: clouddriver_migrate
            jdbcUrl: jdbc:mysql:aws://<RDSHOST>:<PORT>/clouddriver?acceptAwsProtocolOnly=true&useAwsIam=true

        redis:
          enabled: false                  
          cache:
            enabled: false
          scheduler:
            enabled: false # enabled for Google CloudSQL and Amazon Managed RDS SQL https://spinnaker.io/setup/productionize/persistence/clouddriver-sql/#agent-scheduling
          taskRepository:
            enabled: false

        # These parameters help throttle Spinnaker's API calls
        # Default rate limit is 10 req/sec. Adjust and tune as necessary
        # For more details see https://docs.armory.io/docs/armory-admin/rate-limit/
        serviceLimits:
          defaults:
            rateLimit: 10.0
          cloudProviderOverrides:
            aws:
              rateLimit: 10.0
          implementationLimits:
            AmazonAutoScaling:
              defaults:
                rateLimit: 10.0
            AmazonElasticLoadBalancing:
              defaults:
                rateLimit: 10.0
  kustomize:
    clouddriver:
      deployment:
        patchesStrategicMerge:
          - |
            spec:
              template:
                spec:
                  initContainers:
                  - name: iam
                    image: armory/iam-plugin:<PLUGIN_VERSION>
                    imagePullPolicy: Always
                    volumeMounts:
                      - mountPath: /opt/iam/target
                        name: iam-plugin
                  containers:
                  - name: clouddriver
                    volumeMounts:
                      - mountPath: /opt/spinnaker/lib/local-plugins
                        name: iam-plugin
                  volumes:
                  - name: iam-plugin
                    emptyDir: {}
```

Example configuration using the Spinnaker Operator for `orca` service:

```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      spinnaker:
        armory:
          iam-auth:
            awsAccessKeyId: encrypted:k8s!n:spin-secrets!k:awsAccessKeyId # Your AWS Access Key ID. If not provided, the plugin will try to find AWS credentials as described at http://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/credentials.html#credentials-default
            secretAccessKey: encrypted:k8s!n:spin-secrets!k:secretAccessKey # Your AWS Secret Key. If not provided, the plugin will try to find AWS credentials as described at http://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/credentials.html#credentials-default
            region: us-west-2

      orca:
        spinnaker:
          extensibility:
            plugins:
              Armory.IAM:
                enabled: true
            repositories:
              iamPlugin:
                enabled: true
                # The init container will install plugins.json to this path.
                url: file:///opt/spinnaker/lib/local-plugins/iam/plugins.json

        sql:
          enabled: true
          connectionPool:
            jdbcUrl: jdbc:mysql:aws://<RDSHOST>:<PORT>/orca?enabledTLSProtocols=TLSv1.2&acceptAwsProtocolOnly=true&useAwsIam=true
            user: orca_service
            connectionTimeout: 5000
            maxLifetime: 30000
            # MariaDB-specific:
            maxPoolSize: 50
          migration:
            jdbcUrl: jdbc:mysql:aws://<RDSHOST>:<PORT>/orca?enabledTLSProtocols=TLSv1.2&acceptAwsProtocolOnly=true&useAwsIam=true
            user: orca_migrate

        # Ensure we're only using SQL for accessing execution state
        executionRepository:
          sql:
            enabled: true
          redis:
            enabled: false

        # Reporting on active execution metrics will be handled by SQL
        monitor:
          activeExecutions:
            redis: false

  kustomize:
    orca:
      deployment:
        patchesStrategicMerge:
          - |
            spec:
              template:
                spec:
                  initContainers:
                  - name: iam
                    image: armory/iam-plugin:<PLUGIN_VERSION>
                    imagePullPolicy: Always
                    volumeMounts:
                      - mountPath: /opt/iam/target
                        name: iam-plugin
                  containers:
                  - name: orca
                    volumeMounts:
                      - mountPath: /opt/spinnaker/lib/local-plugins
                        name: iam-plugin
                  volumes:
                  - name: iam-plugin
                    emptyDir: {}
```

Example configuration using the Spinnaker Operator for `front50` service:

```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      # Configs in the spinnaker profile get applied to all services
      spinnaker:
        armory:
          iam-auth:
            awsAccessKeyId: encrypted:k8s!n:spin-secrets!k:awsAccessKeyId # Your AWS Access Key ID. If not provided, the plugin will try to find AWS credentials as described at http://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/credentials.html#credentials-default
            secretAccessKey: encrypted:k8s!n:spin-secrets!k:secretAccessKey # Your AWS Secret Key. If not provided, the plugin will try to find AWS credentials as described at http://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/credentials.html#credentials-default
            region: us-west-2
        
      front50:
        spinnaker:
          extensibility:
            plugins:
              Armory.IAM:
                enabled: true
            repositories:
              iamPlugin:
                enabled: true
                # The init container will install plugins.json to this path.
                url: file:///opt/spinnaker/lib/local-plugins/iam/plugins.json
          s3:             # change this to the persistenStoreType you have defined below, s3/gcs/redis/aze for example
            enabled: false # disable the use of persistentStoreType by front50 if no longer needed, after optional migration is complete
        sql:
          connectionPools:
            default:
              default: true
              jdbcUrl: jdbc:mysql://<RDSHOST>:<PORT>/front50?enabledTLSProtocols=TLSv1.2&acceptAwsProtocolOnly=true&useAwsIam=true
              user: front50_service
          enabled: true
          migration:
            jdbcUrl: jdbc:mysql://<RDSHOST>:<PORT>/front50?enabledTLSProtocols=TLSv1.2&acceptAwsProtocolOnly=true&useAwsIam=true
            user: front50_migrate

  kustomize:
    front50:
      deployment:
        patchesStrategicMerge:
          - |
            spec:
              template:
                spec:
                  initContainers:
                  - name: iam
                    image: armory/iam-plugin:<PLUGIN_VERSION>
                    imagePullPolicy: Always
                    volumeMounts:
                      - mountPath: /opt/iam/target
                        name: iam-plugin
                  containers:
                  - name: front50
                    volumeMounts:
                      - mountPath: /opt/spinnaker/lib/local-plugins
                        name: iam-plugin
                  volumes:
                  - name: iam-plugin
                    emptyDir: {}
```

## Known Issues

- ### software.aws.rds.jdbc.mysql.shading.com.mysql.cj.jdbc.exceptions.PacketTooBigException
  The below error message could appear when using the plugin on `clouddriver`, `orca`, and/or `front50`:

  ```shell
  2022-05-27 05:29:51.951  WARN 1 --- [    handlers-19] c.n.s.o.e.DefaultExceptionHandler        : [] Error occurred during task bindProducedArtifacts
  org.springframework.dao.TransientDataAccessResourceException: jOOQ; SQL [insert into pipeline_stages (id, legacy_id, execution_id, status, updated_at, body) values (?, ?, ?, ?, ?, ?) on duplicate key update status = ?, updated_at = ?, body = ? -- executionId: 01G41ZV8QSCH36JTXACPEEWRYD:01G41ZV8TB1S89R4AKEHGX0YS8:3 user: abgv]; Packet for query is too large (75,237 > 65,535). You can change this value on the server by setting the 'max_allowed_packet' variable.; nested exception is software.aws.rds.jdbc.mysql.shading.com.mysql.cj.jdbc.exceptions.PacketTooBigException: Packet for query is too large (75,237 > 65,535). You can change this value on the server by setting the 'max_allowed_packet' variable.
  ```

  The error is a bug on the `software.aws.rds.jdbc.mysql` jdbc library version [1.0.0](https://github.com/awslabs/aws-mysql-jdbc/releases/tag/1.0.0) used inside the plugin. The issue is already fixed, but the release date is unknown at the date of writing this document. You can find more details at the official repository on the following pull request:
  https://github.com/awslabs/aws-mysql-jdbc/issues/191
  https://github.com/awslabs/aws-mysql-jdbc/pull/211

  ### Workaround

  If you are facing the above issue, you can try to include the `maxAllowedPacket` parameter in your `jdbcUrl` in the following way and according to the database and service where you configure this plugin:

  ```yaml
  sql:
    enabled: true
    connectionPools:
      default:
        default: true
        user: <USER>_service
        jdbcUrl: jdbc:mysql:aws://<RDSHOST>:<PORT>/<DATABASE>?acceptAwsProtocolOnly=true&useAwsIam=true&maxAllowedPacket=<MAX_ALLOWED_PACKET>
    migration:
      user: <USER>_migrate
      jdbcUrl: jdbc:mysql:aws://<RDSHOST>:<PORT>/<DATABASE>?acceptAwsProtocolOnly=true&useAwsIam=true&maxAllowedPacket=<MAX_ALLOWED_PACKET>
  ```

  Make sure you have set the `maxAllowedPacket` param in your MySQL Aurora instance/cluster and match the `MAX_ALLOWED_PACKET` values.
  Once a new version of the jdbc library is released, a new version of this plugin will be released, and then this param will be safe to be removed, meanwhile this workaround should work.

## Release Notes

- v1.0.0 Initial plugin release May 31, 2022. Availability to configure AWS IAM Auth for `clouddriver`, `orca`, and `front50` Armory Spinnaker services.

