## Suffix no longer added to jobs created by Kubernetes Run Job stage

Spinnaker no longer automatically appends a unique suffix to the name of jobs created by the Kubernetes Run Job stage. Prior to this release, if you specified `metadata.name: my-job`, Spinnaker updates the name to `my-job-[random-string]` before deploying the job to Kubernetes. As of this release, the job's name will be passed through to Kubernetes exactly as supplied.

To continue having a random suffix added to the job name, set the `metadata.generateName` field instead of `metadata.name`, which causes the Kubernetes API to append a random suffix to the name.

This change is particularly important for users who are using the preconfigured job stage for Kubernetes or are sharing job stages among different pipelines. In these cases, jobs often running concurrently, and it is important that each job have a unique name. In order to retain the previous behavior, manually update your Kubernetes job manifests to use the `generateName` field.

Previously, this behavior was opt-in. 

As of Armory 2.22, this behavior is the default. Users can still opt out of the new behavior by setting `kubernetes.jobs.append-suffix: true` in  `clouddriver-local.yml`. This causes Spinnaker to continue to append a suffix to the name of jobs as in prior releases.

The ability to opt out of the new behavior will be removed in Armory 2.23 (OSS 1.23). The above setting will have no effect, and Spinnaker will no longer append a suffix to job names. We recommended that 2.22 users note which jobs are using the old behavior and prepare to remove the setting before upgrading to Armory 2.23 in the future.

**Introduced in**: Armory 2.22