### Google Cloud Storage (GCS) config missing `bucketLocation` fails

If you have configured a persistent storage or a canary service integration account for GCS without the `bucketLocation` property defined, validation fails with a message similar to this:

```bash
Failed to ensure the required bucket "cristhian-canary" exists: bucketLocation, spinnakerConfig.config.default.canary: Failed to ensure the required bucket "cristhian-canary" exists: bucketLocation, spinnakerConfig.config.default.canary.google.gcp-canary: Failed to ensure the required bucket "cristhian-canary" exists: bucketLocation
```

**Workaround**

If you don't have a bucket location, you should configure `bucketLocation` as a blank string. See the `bucketLocation` key in the following example:

```yaml
persistentStorage:
  gcs:
    bucket: <your-bucket-name>
    bucketLocation: "" # use an emptry string if you don't have a bucket location
    jsonPath: <path-to-encrypted-json-file>
    project: <your-cloud-project>
    rootFolder: front50
  persistentStoreType: gcs
```


**Affected versions:** Halyard 1.12.0, Armory Operator 1.2.6

**Fixed versions:** Halyard 1.12.01, Armory Operator 1.2.7

**Context**

A [pull request](https://github.com/spinnaker/halyard/pull/1851) to open source Halyard updated Front50 and introduced a change for `GcsStorageService`. Prior to the rewrite of `GcsStorageService`, Front50 accepted either null or an empty string as the bucket location. Now that `GcsStorageService` is written in Kotlin and does not use a String for the field, an error occurs on trying to create the `GcsStorageService` if `bucketLocation` is null.