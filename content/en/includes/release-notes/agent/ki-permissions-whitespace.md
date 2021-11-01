### Kubernetes account permissions format
<!-- SUPPORT-3482 -->
```yaml
kubernetes:
  accounts:
    - name: my-k8s-account
      permissions:
        - READ: ['role1', 'role2']
        - WRITE: ['role3', 'role4']
```

Make sure that there are no whitespaces in the role configurations under the `READ` and `WRITE` tags. The permissions are not applied if there are whitespaces in the configuration. This means that all users will have access to the defined account.

**Affected versions**: all versions