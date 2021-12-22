### Canary validation

When canary validators are enabled and users add `metadataCachingIntervalMS` to the canary configuration, deployment fails with the following error message in the Operator logs:

```text
json: cannot unmarshal number into Go struct field PrometheusCanaryServiceIntegration.metadataCachingIntervalMS of type bool
```

**Workaround**

None.

**Affected versions:** Armory Operator 1.4.0, 1.4.1

**Fixed versions:** Armory Operator 1.5.1
