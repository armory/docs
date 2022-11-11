#### `pipelineID` for Pipelines as Code

There is a known issue where the `pipelineID` function does not work the first time, which causes pipelines to not be updated. Subsequent changes to the `dinghyfile` update the pipelines correctly.

Affected versions: 2.21.1 - 2.26.0
Fixed version: 2.26.1
