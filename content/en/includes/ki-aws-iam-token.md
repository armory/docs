#### AWS IAM tokens

There is a known issue where fetching an AWS token might take longer than expected. The problem occurs because of an issue with version 0.5.0 of the `aws-iam-authenticator`, which is included in this release.

For more information, see [347](https://github.com/kubernetes-sigs/aws-iam-authenticator/issues/347).

**Workaround**

You can use the `aws` CLI to fetch tokens instead of `aws-iam-authenticator`.

**Affected versions:** 2.22.0
**Fixed versions**: 2.22.1 and later