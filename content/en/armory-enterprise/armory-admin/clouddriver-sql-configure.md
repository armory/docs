---
title: Configure Clouddriver to use a SQL Database
linkTitle: Configure Clouddriver to use SQL
aliases:
  - /spinnaker_install_admin_guides/clouddriver-sql/
  - /docs/spinnaker-install-admin-guides/clouddriver-sql/
description: >
  Configure Spinnaker's Clouddriver service to use MySQL-compatible database.
---

## Advantages of using an RDMS with Clouddriver

Since version 2.5.x (OSS 1.14.x), Clouddriver can store its data (task, infrastructure, etc) in a MySQL-compatible database. Similar to Orca, the main advantage of doing this is to improve performance and remove Redis as a single point of failure.

{{< include "db-compat.md" >}}

Armory recommends MySQL 5.7 or AWS Aurora.

## Base configuration

You can find a complete description of the options in the [open source documentation](https://www.spinnaker.io/setup/productionize/persistence/clouddriver-sql/).

## Database setup

You can skip this step if you create the database during provisioning - for instance with Terraform.

Once you've provisioned your RDBMS and ensured connectivity with Spinnaker, you need to create the database:

```sql
CREATE SCHEMA `clouddriver` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

Then we'll grant authorization to the `clouddriver_service` and `clouddriver_migrate` users:

```sql

  GRANT
    SELECT, INSERT, UPDATE, DELETE, CREATE, EXECUTE, SHOW VIEW
  ON `clouddriver`.*
  TO 'clouddriver_service'@'%';

  GRANT
    SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, REFERENCES, INDEX, ALTER, LOCK TABLES, EXECUTE, SHOW VIEW
  ON `clouddriver`.*
  TO `clouddriver_migrate`@'%';
```

This configuration grants authorization from any host. You can restrict it to the cluster in which Spinnaker runs by replacing the `%` with the IP address of Clouddriver pods from MySQL.

> Depending on your TLS settings, you may need to configure TLS 1.2. For more information, see the Knowledge Base articles [Disabling TLS 1.1 in Spinnaker and Specifying the Protocols to be used](https://support.armory.io/support?sys_kb_id=6d38e4bfdba47c1079f53ec8f49619c2&id=kb_article_view&sysparm_rank=2&sysparm_tsqueryId=f93349771b3d385013d4fe6fdc4bcb35) and [How to fix TLS error "Reason: extension (5) should not be presented in certificate_request"](https://support.armory.io/support?sys_kb_id=e06335f11b202c1013d4fe6fdc4bcbf8&id=kb_article_view&sysparm_rank=1&sysparm_tsqueryId=3b0341771b3d385013d4fe6fdc4bcb6a).

## Deployment

You have two options for deploying Clouddriver with MySQL: a simpler deployment, which involves downtime, or a three-step method that avoids downtime. Pick the method that best fits your requirements.

### Simple deployment

If you are not worried about downtime or if Spinnaker is not currently executing any pipelines, you can run a simple deployment by adding the following snippet to `SpinnakerService` manifest under `spec.spinnakerConfig.profiles.clouddriver` if using the Operator, or to `<HALYARD>/<DEPLOYMENT>/profiles/clouddriver-local.yml` if using Halyard:

```yaml
sql:
  enabled: true
  taskRepository:
    enabled: true
  cache:
    enabled: true
    # These parameters were determined to be optimal via benchmark comparisons
    # in the Netflix production environment with Aurora. Setting these too low
    # or high may negatively impact performance. These values may be sub-optimal
    # in some environments.
    readBatchSize: 500
    writeBatchSize: 300
  scheduler:
    enabled: true
  connectionPools:
    default:
      # additional connection pool parameters are available here,
      # for more detail and to view defaults, see:
      # https://github.com/spinnaker/kork/blob/master/kork-sql/src/main/kotlin/com/netflix/spinnaker/kork/sql/config/ConnectionPoolProperties.kt
      default: true
      jdbcUrl: jdbc:mysql://your.database:3306/clouddriver
      user: clouddriver_service
      # password: depending on db auth and how spinnaker secrets are managed
    # The following tasks connection pool is optional. At Netflix, clouddriver
    # instances pointed to Aurora read replicas have a tasks pool pointed at the
    # master. Instances where the default pool is pointed to the master omit a
    # separate tasks pool.
    tasks:
      user: clouddriver_service
      jdbcUrl: jdbc:mysql://your.database:3306/clouddriver
  migration:
    user: clouddriver_migrate
    jdbcUrl: jdbc:mysql://your.database:3306/clouddriver

redis:
  enabled: false
  cache:
    enabled: false
  scheduler:
    enabled: false
  taskRepository:
    enabled: false
```


### No downtime deployment

To avoid downtime for your deployment, use the following three steps:

#### Step 1:  Warm up the cache

The first step is to start a Clouddriver that is not accessible from other services to validate the installation and warm up the cache.

You can do it manually or by using the [following script](https://gist.github.com/ncknt/983bb800451f00b39401852fefde69bf). Make sure tables are properly created and being populated by these instances of Clouddriver.

#### Step 2:  Use MySQL to back new tasks

After waiting a few minutes (from 2 to 10 minutes depending on how many accounts are connected), we'll update Spinnaker to use MySQL but remain aware of task statuses in Redis.

We're deploying Spinnaker with the following configuration in `SpinnakerService` manifest under the key `spec.spinnakerConfig.profiles.clouddriver` if using the Operator, or in `clouddriver-local.yml` if using Halyard:

```yaml
sql:
  enabled: true
  taskRepository:
    enabled: true
  cache:
    enabled: true
    # These parameters were determined to be optimal via benchmark comparisons
    # in the Netflix production environment with Aurora. Setting these too low
    # or high may negatively impact performance. These values may be sub-optimal
    # in some environments.
    readBatchSize: 500
    writeBatchSize: 300
  scheduler:
    enabled: true
  connectionPools:
    default:
      # additional connection pool parameters are available here,
      # for more detail and to view defaults, see:
      # https://github.com/spinnaker/kork/blob/master/kork-sql/src/main/kotlin/com/netflix/spinnaker/kork/sql/config/ConnectionPoolProperties.kt
      default: true
      jdbcUrl: jdbc:mysql://your.database:3306/clouddriver
      user: clouddriver_service
      # password: depending on db auth and how spinnaker secrets are managed
    # The following tasks connection pool is optional. At Netflix, clouddriver
    # instances pointed to Aurora read replicas have a tasks pool pointed at the
    # master. Instances where the default pool is pointed to the master omit a
    # separate tasks pool.
    tasks:
      user: clouddriver_service
      jdbcUrl: jdbc:mysql://your.database:3306/clouddriver
  migration:
    user: clouddriver_migrate
    jdbcUrl: jdbc:mysql://your.database:3306/clouddriver

redis:
  cache:
    enabled: false
  scheduler:
    enabled: false

executionRepository:
  dual:
    enabled: true
    primaryName: sqlExecutionRepository
    previousClass: redisExecutionRepository
```

> At this point, you can stop the pods you created in step 1. If you used the preceding script, just delete the `spin-clouddriver-sql` deployment.

#### Step 3:  Remove Redis

After waiting a few minutes so that Redis tasks are no longer relevant, finish by removing Redis entirely:

```yaml
sql:
  enabled: true
  taskRepository:
    enabled: true
  cache:
    enabled: true
    # These parameters were determined to be optimal via benchmark comparisons
    # in the Netflix production environment with Aurora. Setting these too low
    # or high may negatively impact performance. These values may be sub-optimal
    # in some environments.
    readBatchSize: 500
    writeBatchSize: 300
  scheduler:
    enabled: true
  connectionPools:
    default:
      # additional connection pool parameters are available here,
      # for more detail and to view defaults, see:
      # https://github.com/spinnaker/kork/blob/master/kork-sql/src/main/kotlin/com/netflix/spinnaker/kork/sql/config/ConnectionPoolProperties.kt
      default: true
      jdbcUrl: jdbc:mysql://your.database:3306/clouddriver
      user: clouddriver_service
      # password: depending on db auth and how spinnaker secrets are managed
    # The following tasks connection pool is optional. At Netflix, clouddriver
    # instances pointed to Aurora read replicas have a tasks pool pointed at the
    # master. Instances where the default pool is pointed to the master omit a
    # separate tasks pool.
    tasks:
      user: clouddriver_service
      jdbcUrl: jdbc:mysql://your.database:3306/clouddriver
  migration:
    user: clouddriver_migrate
    jdbcUrl: jdbc:mysql://your.database:3306/clouddriver

redis:
  enabled: false
  cache:
    enabled: false
  scheduler:
    enabled: false
  taskRepository:
    enabled: false
```
