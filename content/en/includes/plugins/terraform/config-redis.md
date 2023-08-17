Terraform Integration uses Redis to store Terraform logs and plans.

>You can only configure the Terraform Integration feature to use a password with the default Redis user.

Configure Redis settings in your configuration and then apply.

```yaml
spec:
  spinnakerConfig:
    profiles:
      terraformer:
        redis:
          baseUrl: "redis://spin-redis:6379"
          password: "password"
```