
#### SpEL expressions and artifact binding

There is an issue where it appears that SpEL expressions are not being evaluated properly in manifests for events such as the Deploy Manifest stage. What is actually happening is that an artifact binding is overriding the image value.

**Workaround**:

2.27.x: Disable artifact binding by adding the following parameter to the stage JSON: `enableArtifactBinding: false`.

2.26.x: Change the artifact binding behavior in `spec.spinnakerConfig.profiles.clouddriver` (Operator) or  `clouddriver-local.yml` (Halyard) to the following, which causes artifacts to only bind the version when the tag is missing:

```yaml
kubernetes:
  artifact-binding:
    docker-image: match-name-only
```

**Affected versions**: 2.26.x and later