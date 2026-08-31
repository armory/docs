### Clouddriver fails to start with a Kubesvc migration error

When you upgrade an environment that previously ran the Armory Scale Agent as the `Armory.Kubesvc` plugin, the built-in Kubernetes Agent (Kubesvc) runs its database migrations against a separate Liquibase changelog table (`KUBESVC_AGENT_CHANGELOG`) instead of Clouddriver's `DATABASECHANGELOG` table. Because the previous changelog history isn't there, the agent tries to re-create tables that the plugin already created, and Clouddriver fails to start with:

```text
Migration failed for changeset db/changelog/20200122-initial-schema-optimized.yml::create-kubesvc-table::ncknt
Reason: Table 'kubesvc_cache' already exists
[Failed SQL: (1050) CREATE TABLE clouddriver.kubesvc_cache (...)]
  at io.armory.kubesvc.sql.SpringLiquibaseKubesvc.afterPropertiesSet
```

**Affected versions**: Armory CD 2.38.0 and later, when upgrading from an installation that used the `Armory.Kubesvc` plugin

**Workaround**: Copy the Kubesvc changelog entries from Clouddriver's `DATABASECHANGELOG` table into `KUBESVC_AGENT_CHANGELOG` so the built-in agent recognizes the migrations as already applied.

1. Back up your Clouddriver database.
2. Scale Clouddriver down to zero replicas. The failed startup attempt creates the empty `KUBESVC_AGENT_CHANGELOG` table, so run the upgrade at least once before executing the statement below.
3. Run the following statement against your Clouddriver database. Replace the `clouddriver` schema name if your database uses a different one.

   ```sql
   INSERT INTO clouddriver.KUBESVC_AGENT_CHANGELOG
     (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, EXECTYPE, MD5SUM,
      DESCRIPTION, COMMENTS, TAG, LIQUIBASE, CONTEXTS, LABELS, DEPLOYMENT_ID)
   SELECT ID, AUTHOR, REPLACE(FILENAME, 'classpath:', ''), DATEEXECUTED, ORDEREXECUTED, EXECTYPE, NULL,
          DESCRIPTION, COMMENTS, TAG, LIQUIBASE, CONTEXTS, LABELS, DEPLOYMENT_ID
   FROM clouddriver.DATABASECHANGELOG
   WHERE REPLACE(FILENAME, 'classpath:', '') IN (
     'db/changelog/20200122-initial-schema-optimized.yml',
     'db/changelog/20200221-initial-schema.yml',
     'db/changelog/20200615-account-extra.yml',
     'db/changelog/20200810-account-props.yml',
     'db/changelog/20201120-namespace.yml',
     'db/changelog/20201223-artifacts.yml',
     'db/changelog/20211115-resourceversion.yml',
     'db/changelog/20211223-agentid-assignments.yml',
     'db/changelog/20220112-schema-kubesvc_ops_history.yml',
     'db/changelog/20220203-update-kubesvc-assignment-idx.yml',
     'db/changelog/20220531-add-zone-id.yml',
     'db/changelog/20220607-schema-kubesvc_zones_table.yml',
     'db/changelog/20220622-add-dynamic-acc-indicator.yml',
     'db/changelog/20220622-alter-kubesvc-accounts-add-status-column.yml',
     'db/changelog/20220708-account-definition.yml',
     'db/changelog/20220711-account-error.yml',
     'db/changelog/20221109-schema-kubesvc_locks.yml',
     'db/changelog/20221208-schema-kubesvc_instances.yml',
     'db/changelog/20221210-account-failed-count.yml',
     'db/changelog/20221215-update-kubesvc_instances.yml',
     'db/changelog/20230307-schema-operations-refactor.yml',
     'db/changelog/20230320-alter-kubesvc_accounts-add-connections-column.yml',
     'db/changelog/20230706-alter-kubesvc_assignments.yml'
   );
   ```

4. Scale Clouddriver back up. The built-in agent skips the already-applied changesets and recomputes the `MD5SUM` values, and Clouddriver starts normally.
