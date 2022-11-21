### SpEL expressions and artifact binding

There is an issue where it appears that SpEL expressions are not being evaluated properly in artifact declarations (such as container images) for events such as the Deploy Manifest stage. What is actually happening is that an artifact binding is overriding the image value.

**Workaround**:

2.27.x or later: Disable artifact binding by adding the following parameter to the stage JSON: `enableArtifactBinding: false`.

2.26.x or later: Change the artifact binding behavior in `spec.spinnakerConfig.profiles.clouddriver` (Operator) or  `clouddriver-local.yml` (Halyard) to the following, which causes artifacts to only bind the version when the tag is missing:

```yaml
kubernetes:
  artifact-binding:
    docker-image: match-name-only
```

This setting only binds the version when the tag is missing, such as `image: nginx` without a version number.

**Affected versions**: Armory CD 2.26.x and later
