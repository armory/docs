To enable [AWS CloudWatch](https://aws.amazon.com/cloudwatch/), update the AWS configuration entry in your `kayenta-local.yml` file. Make sure `METRICS_STORE` is listed under `supportedTypes`. Add the `cloudwatch` entry with `enabled: true`.

This example uses S3 as the object store and CloudWatch as the metrics store.

```yaml
kayenta:
  aws:
    enabled: true
    accounts:
      - name: monitoring
        bucket: <your-s3-bucket>
        region: <your-region>
        # Kayenta can assume a role when connecting to Cloudwatch using the iamRole configs
        # iamRoleArn: <your-role-ARN> # For example arn:aws:iam::042225624470:role/theRole
        # iamRoleExternalId: Optional. For example 12345
        # iamRoleArnTarget: <your-role-ARN-target> # For example arn:aws:iam::042225624470:role/targetcloudwatchaccount
        # iamRoleExternalIdTarget: <your-ExternalID> # Optional. For example 84475
        rootFolder: kayenta
        roleName: default
        supportedTypes:
          - OBJECT_STORE
          - CONFIGURATION_STORE
          - METRICS_STORE
  cloudwatch:
    enabled: true
  s3:
    enabled: true
```