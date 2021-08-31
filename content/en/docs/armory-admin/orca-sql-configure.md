---
title: Configure Spinnaker's Orca Service to Use SQL RDBMS
linkTitle: Configure Orca to use SQL
aliases:
  - /spinnaker_install_admin_guides/orca-sql/
  - /docs/spinnaker-install-admin-guides/orca-sql/
description: >
  Configure Spinnaker's Orca service to use an RDBMS to store its pipeline execution.
---

## Advantages to using an RDMS with Orca

By default, Spinnaker's task orchestration service, Orca, uses Redis as its backing store. You can configure Orca to use a relational database instead of Redis to store its pipeline execution. The main advantage of doing so is a gain in performance and the removal of Redis as a single point of failure.

Armory recommends MySQL 5.7. For AWS, you can use Aurora.

## Base configuration

You can find a complete description of configuration options in the Open Source Spinnaker [documentation](https://www.spinnaker.io/setup/productionize/persistence/orca-sql/).

You can configure your SQL database by adding the following snippet to `SpinnakerService` manifest under `spec.spinnakerConfig.profiles.orca` if using the Operator, or to `<HALYARD>/<DEPLOYMENT>/profiles/orca-local.yml` if using Halyard:

```yaml
sql:
  enabled: true
  connectionPool:
    jdbcUrl: jdbc:mysql://<DB CONNECTION HOSTNAME>:<DB CONNECTION PORT>/<DATABASE NAME>
    user: orca_service
    password: <orca_service password>
    connectionTimeout: 5000
    maxLifetime: 30000
    maxPoolSize: 50
  migration:
    jdbcUrl: jdbc:mysql://<DB CONNECTION HOSTNAME>:<DB CONNECTION PORT>/<DATABASE NAME>
    user: orca_migrate
    password: <orca_migrate password>

# Ensure we're only using SQL for accessing execution state
executionRepository:
  sql:
    enabled: true
  redis:
    enabled: false

monitor:
  activeExecutions:
    redis: false
```

> Depending on your TLS settings, you may need to configure TLS 1.2. For more information, see the Knowledge Base articles [Disabling TLS 1.1 in Spinnaker and Specifying the Protocols to be used](https://support.armory.io/support?sys_kb_id=6d38e4bfdba47c1079f53ec8f49619c2&id=kb_article_view&sysparm_rank=2&sysparm_tsqueryId=f93349771b3d385013d4fe6fdc4bcb35) and [How to fix TLS error "Reason: extension (5) should not be presented in certificate_request"](https://support.armory.io/support?sys_kb_id=e06335f11b202c1013d4fe6fdc4bcbf8&id=kb_article_view&sysparm_rank=1&sysparm_tsqueryId=3b0341771b3d385013d4fe6fdc4bcb6a).

## Create the `orca` database and configure authorization

Once you've provisioned your RDBMS and ensured connectivity from Spinnaker, you need to create the database. You can skip this step if you created the database during provisioning.

```sql
CREATE SCHEMA `orca` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

Grant authorization to the `orca_service` and `orca_migrate` users:

```sql

  GRANT
    SELECT, INSERT, UPDATE, DELETE, EXECUTE, SHOW VIEW
  ON `orca`.*
  TO 'orca_service'@'%';

  GRANT
    SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, REFERENCES, INDEX, ALTER, LOCK TABLES, EXECUTE, SHOW VIEW
  ON `orca`.*
  TO 'orca_migrate'@'%';
```

The above configuration grants authorization from any host. You can restrict it to the cluster in which Spinnaker runs by replacing the `%` with the IP address of Orca pods from MySQL.

## Migrate from Redis to SQL to keep existing execution history

The above configuration will point Orca to your database.
You have the option to run a dual repository by adding `dual` in `profiles/orca-local.yml`.

Armory v2.18+:

```yaml
executionRepository:
  dual:
    enabled: true
    primaryName: sqlExecutionRepository
    previousName: redisExecutionRepository
  sql:
    enabled: true
  redis:
    enabled: true
```

Armory versions prior to v2.18:

```yaml
executionRepository:
  dual:
    enabled: true
    primaryClass: com.netflix.spinnaker.orca.sql.pipeline.persistence.SqlExecutionRepository
    previousClass: com.netflix.spinnaker.orca.pipeline.persistence.jedis.RedisExecutionRepository

  sql:
    enabled: true
  redis:
    enabled: true
```

However, this configuration won't migrate your existing execution history to your new database. This will make your Spinnaker instance run on both the SQL and Redis backend. Spinnaker will only write the new execution on SQL but will continue to read the data on Redis.
To migrate the data from Redis to SQL, you need to add the following

```yaml
pollers:
  orchestrationMigrator:
    enabled: true
    intervalMs: 1800000
  pipelineMigrator:
    enabled: true
    intervalMs: 1800000  # After how much time the migration process is going to start
```

Once everything has been migrated (you will see logs in the orca pod about the migration process) you can remove these settings.

<!-- ## Support for Other Relational Databases
<div class="alpha-warning">
  Database engines other than MySQL and its variants such as Aurora with MySQL are not currently officially supported.
</div>

To try a different database you can switch the JDBC URL and set the `dialect` in the properties:

```yaml
sql:
  enabled: true
  connectionPool:
    jdbcUrl: jdbc:<DRIVER>://<DB CONNECTION HOSTNAME>:<DB CONNECTION PORT>/<DATABASE NAME>
    dialect: <DIALECT VALUE>
    ...
  migration:
    jdbcUrl: jdbc:<DRIVER>://<DB CONNECTION HOSTNAME>:<DB CONNECTION PORT>/<DATABASE NAME>
    dialect: <DIALECT VALUE>
    ...
```

You can find the dialect below:

| Database       | Dialect Value   |
| ------------   | --------------- |
| MariaDB        | `MARIADB`       |
| MySQL          | `MYSQL` (default) |
| PostgreSQL     | `POSTGRES`      |
| PostgreSQL 9.3 | `POSTGRES_9_3`  |
| PostgreSQL 9.4 | `POSTGRES_9_4`  |
| PostgreSQL 9.5 | `POSTGRES_9_5`  | -->


## Database maintenance

Each new version of Orca may potentially migrate the database schema. This is done with the `orca_migrate` user defined above.

Pipeline executions are saved to the database. Each execution can add between a few KBs to hundreds of KBs of data depending on the size of your pipeline.
It means that after a while, data will grow large and you'll likely want to purge older executions.

Note: We recommend saving past executions to a different data store for auditing purposes. You can do it in a variety of ways:
- During the purge, by marking, exporting, then deleting older records.
- By saving execution history from Echo's events and just delete older records from your database.
