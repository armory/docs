
#### Git Artifact Constraint Trigger

When setting an artifact constraint to limit when a pipeline executes on a git web hook, it's likely the trigger will break with an error message
The following required artifacts could not be bound: '[ArtifactKey(type=docker/image, ...'
See https://github.com/spinnaker/spinnaker/issues/6757
