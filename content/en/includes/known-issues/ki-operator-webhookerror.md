#### Internal error, failed calling webhook when deploying Armory Enterprise Spinnaker with a new Operator after Upgrade

After running the following command: `kubectl -n armory apply -k overlays/dev/`, admins will get the following exception:

```Error from server (InternalError): error when creating "overlays/dev/": Internal error occurred: failed calling webhook "webhook-spinnakerservices-v1alpha2.spinnaker.armory.io": Post "https://spinnaker-operator.armory.svc:443/validate-spinnaker-armory-io-v1alpha2-spinnakerservice?timeout=10s": context deadline exceeded
``` 

Or an exception like this:

```Error from server (InternalError): error when creating "STDIN": Internal error occurred: failed calling webhook "webhook-spinnakerservices-v1alpha2.spinnaker.armory.io": Post "https://spinnaker-operator.armory-operator.svc:443/validate-spinnaker-armory-io-v1alpha2-spinnakerservice?timeout=10s": no endpoints available for service "spinnaker-operator"
```

To resolve this issue, customers should refer to [KB article KB0010638](https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010638)

**Affected versions**: 1.7.3+