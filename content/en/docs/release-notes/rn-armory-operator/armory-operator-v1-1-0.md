---
title: v1.1.0 Armory Operator
toc_hide: true
version: 01.01.00
---

## 08/11/2020 Release Notes

## Known Issues

This release does not include updated permissions for the Operator to manage
Ingress objects. You can add the following to the role that is created for the
operator in your cluster:

```yaml
- apiGroups:
    - networking.k8s.io
    - extensions
  resources:
    - ingresses
  verbs:
    - get
    - list
    - watch
```

This will be addressed in a patch release for the `1.1.x` release line.

## Highlights

### Ingress Support

`spec.expose.type: ingress`. When `ingress` is selected, the Operator tries to find an ingress rule
in the same namespace as Spinnaker that points to Gate or Deck. It will then compute these services' hostnames using either `spec.rules[].host` or `status.loadBalancer.ingress[0].hostname`.

Both `extensions` and `networking.k8s.io` ingresses are supported and queried.

For Gate, the Operator also checks for the path and sets up Spinnaker to support relative paths.

The following example sets up Spinnaker's UI (Deck) at `http://acme.com` and API (Gate) at `http://acme.com/api`:

```yaml
kind: Ingress
apiVersion: extensions/v1beta1
metadata:
  name: my-ingress
  namespace: spinnaker
spec:
  rules:
    - http:
        paths:
          - path: /api
            backend:
              serviceName: spin-gate
              servicePort: http
          - path: /
            backend:
              serviceName: spin-deck
              servicePort: 9000
status:
  loadBalancer:
    ingress:
      - hostname: acme.com
```

This example sets up the UI (Deck) at `https://acme.com` and API (Gate) at `https://acme.com/api/v1`:

```yaml
kind: Ingress
apiVersion: networking.k8s.io/v1beta1
metadata:
  name: my-ingress
  namespace: spinnaker
spec:
  tls:
    - hosts: [ 'example.com', 'acme.com'] # That's how we know TLS is supported
  rules:
    - host: acme.com
      http:
        paths:
          - path: /api
            backend:
              serviceName: spin-gate
              servicePort: http
          - path: /
            backend:
              serviceName: spin-deck
              servicePort: 9000
```

## Detailed updates

### Armory Operator

* chore(release): upgrade to oss operator 1.1.0
* chore(vault): Error messages not capitalized
* fix(kustomize): Make kustomization.yml more compatible so that it works with `kubectl` and `kustomize`
* feat(vault): Mount vault's self-signed CA into services

### Spinnaker Operator

* fix(validation): name ports in generated service, declare container ports in manifest
* fix(accounts): Add Spring profile on specialized services
* feat(expose/ingress): ingress support, name all ports on services, fix config clone
* fix(validation): Issue patch to update status
* fix(validation): Add parallel validation support; making `kubectl apply` calls much quicker
* chore(release): Updated halyard version
* fix(defaults): Use long delays instead of `archaius.enabled: false` to not break hystrix defaults
* feat(settings): Global service-settings
* fix(secrets): Prevent panic if a file in secret is empty
* chore(errors): Better error messages validating kubeconfig files
