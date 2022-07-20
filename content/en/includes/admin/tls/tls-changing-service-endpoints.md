Use the Operator to change Spinnaker's service endpoints.

Change the SpinnakerService custom resource:

```yaml
kind: SpinnakerService
...
spec:
  spinnakerConfig:
    service-settings:
      clouddriver:
        baseUrl: https://spin-clouddriver.<NAMESPACE>:7002
      dinghy:
        baseUrl: https://spin-dinghy.<NAMESPACE>:8081
      echo:
        baseUrl: https://spin-echo.<NAMESPACE>:8089
      fiat:
        baseUrl: https://spin-fiat.<NAMESPACE>:7003
      front50:
        baseUrl: https://spin-front50.<NAMESPACE>:8080
      gate:
        baseUrl: https://spin-gate.<NAMESPACE>:8084
      kayenta:
        baseUrl: https://spin-kayenta.<NAMESPACE>:8090
      orca:
        baseUrl: https://spin-orca.<NAMESPACE>:8083
      igor:
        baseUrl: https://spin-igor.<NAMESPACE>:8088
      rosco:
        baseUrl: https://spin-rosco.<NAMESPACE>:8087
      terraformer:
        baseUrl: https://spin-terraformer.<NAMESPACE>:7088
```

