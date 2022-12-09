---
title: Example Policies
linkTitle: Example Policies
description: This page collects and indexes all the example policies in the Policy Engine package documentation.
---

- Requires a reason to be provided for any rollback. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.execution/stages.before/undoRolloutManifest.md" >}} )

- This policy will prevent scaleManifest stages from running in a pipeline unless it is triggered by a webhook with a source of 'prometheus' ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.execution/stages.before/scaleManifest.md" >}} )

- This example policy will prevent execution of any manual judgement stage that can be approved by multiple roles, or for which the approving role is not on a whitelist of approving roles. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.execution/stages.before/manualJudgment.md" >}} )

- This policy will prevent a pipeline from starting execution of other pipelines unless it waits for them to complete before continuing. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.execution/stages.before/pipeline.md" >}} )

- This example policy requires delete manifest stages to provide a minimum 2 minute grace period when run in production. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.execution/stages.before/deleteManifest.md" >}} )

- Requires that baked images are of type `hvm`. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.execution/stages.before/bake.md" >}} )

- This policy requires that a set of annotations have been applied to any manifests that are being deployed. Specifically the annotations 'app' and 'owner' must have been applied. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.execution/stages.before/deployManifest.md" >}} )

- This policy prevents exposing a set of ports that are unencrypted buy have encrypted alternatives. Specifically this policy prevents exposing HTTP, FTP, TELNET, POP3, NNTP, IMAP, LDAP, and SMTP from a pod, deployment, or replicaset. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.execution/stages.before/deployManifest.md" >}} )

- This policy checks whether or not the image being approved is on a list of imaged that are approved for deployment. The list of what images are approved must seperately be uploaded to the OPA data document ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.execution/stages.before/deployManifest.md" >}} )

- This policy prevents applications from deploying to namespaces that they are not whitelisted for. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.execution/stages.before/deployManifest.md" >}} )

- This example disables the use of concourse stages. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.execution/stages.before/concourse.md" >}} )

- Prevent server groups from being created in production with fewer than 1 instance. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.execution/stages.before/createServerGroup.md" >}} )

- This example checks the manifest being applied and ensures that it contains a set of required annotations. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.execution/stages.before/patchManifest.md" >}} )

- This example prevents patchManifest stages from running unless they require recording the patch annotation. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.execution/stages.before/patchManifest.md" >}} )

- Disables the **Configure Application**, **Create Application**, and **Create Project** buttons in the UI for non-admin users unless they have a particular role. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.ui.entitlements.isFeatureEnabled/_index.md" >}} )

- Requires a manual approval by the `qa` role, and a manual approval by the `infosec` role happen earlier in a pipeline than any deployment to a production account. Production accounts must have been loaded into the OPA data document in an array named `production_accounts`. ([ opa.pipelines ]({{< ref "opa.pipelines.md#manual-approval-by-role" >}}))

- Only allows applications to deploy to namespaces that are on an allow list. ([ opa.pipelines ]({{< ref "opa.pipelines.md#allow-list-for-target-namespaces" >}}))

- Prevents users from saving pipelines that deploy to production unless the pipeline includes a deployment window. Executions outside of that window are not allowed.  ([ opa.pipelines ]({{< ref "opa.pipelines.md#deployment-window" >}}))

- This policy prevents scaling a deployment or replicaset in a production account to have <2 replicas. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.deployment/tasks.before/scaleManifest.md" >}} )

- This example policy will prevent deleteManifest tasks from running unless they provide a grace period of 30 seconds or more. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.deployment/tasks.before/deleteManifest.md" >}} )

- Prevents cleanupArtifacts tasks from running on any account in a predefined list. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.deployment/tasks.before/cleanupArtifacts.md" >}} )

- This example prevents deploying of pods, pod templates (deployments/jobs/replicasets) and services that use the following services: HTTP, FTP, TELNET, POP3, NNTP, IMAP, LDAP, SMTP ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.deployment/tasks.before/deployManifest.md" >}} )

- This policy simply grants all users access to all APIs. It is a good policy to enable on `spinnaker.http.authz` if you do not need a more complicated policy. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.http.authz/_index.md" >}} )

- This policy disables the ability to create new applications for non-admin users unless their role is 'applicationCreators' ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.http.authz/tasks/type.createApplication.md" >}} )

- This policy disables the ability to create new applications, or update existing applications unless the applications have specified at least 1 role with 'write' permissions. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.http.authz/tasks/type.createApplication.md" >}} )

- This example will prevent users from deleting deployed manifests from production accounts on the 'Clusters' tab of the spinnaker UI. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.http.authz/tasks/type.deleteManifest.md" >}} )

- This policy prevents requires users to enter a reason when performing a scale from outside or a pipeline. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.http.authz/tasks/type.scaleManifest.md" >}} )

- This policy prevents non-admin users from initiating a scaleManifest from the 'clusters' tab of an application. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.http.authz/tasks/type.scaleManifest.md" >}} )

- This policy disables the ability to create new applications, or update existing applications unless the applications have specified at least 1 role with 'write' permissions. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.http.authz/tasks/type.updateApplication.md" >}} )

- Prevents editing manifests from outside of a pipeline on production accounts. ({{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.http.authz/tasks/type.deployManifest.md" >}} )

- Restrict which named users can edit which pipelines for which applications. Any pipeline not explicitly specified in the policy is editable as usual. ( {{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/spinnaker.execution/stages.before/savePipeline" >}} )
