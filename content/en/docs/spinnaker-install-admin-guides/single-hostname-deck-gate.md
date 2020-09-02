---
layout: post
title: Serving Gate on the Same Hostname as Deck
weight: 44
---

## Overview 

The Spinnaker microservice "Gate" serves as the API gateway for Spinnaker and is leveraged by the Spinnaker microservice
"Deck" to display various Spinnaker data via a user interface.  In order to successfully use the Deck UI, both Spinnaker Deck and
Spinnaker Gate but be accessible via DNS.  The standard approach to configuring access to both Deck and Gate is to set 
DNS routing to each service on separate hostnames or separate sub-domains of the same hostname.  While this approach is 
typical, it increases the complexity of both DNS management and Ingress management into Kubernetes.

To simplify both DNS management and Ingress management, Spinnaker can be configured to serve the Gate microservice on 
the same hostname as the Deck UI but located at a sub-path.  Armory recommends configuring the Gate microservice to be
served from the `/api/v1` of the Deck UI hostname when using a single hostname for both Deck and Gate.

For the purposes of this document, we will make the following assumption(s):
1. Spinnaker Deck will be accessible at `https://spinnaker.example.com`
2. Spinnaker Gate will be accessible at `https://spinnaker.example.com/api/v1`
3. Kubernetes Ingress and Service will be used to route traffic from these paths to port 8084 on Gate and 9000 on Deck.

NOTE:  Configuring a Kubernetes Ingress and Service is outside the scope of this document.

We have provided configuration instructions below for both Operator and Halyard configuration management approaches.

### Operator Approach

Step 1: Set Gate's server servlet to be aware of its context path at `/api/v1` in your `SpinnakerService` config.

Add the following under the `spec.spinnakerConfig.profiles` section:

```yaml
gate:
  server:
    servlet:
      context-path: /api/v1
```

Step 2: Set Gate's health endpoint to `/api/v1/health` in your `SpinnakerService` config.

Add the following under the `spec.spinnakerConfig.service-settings` section:

```yaml
gate:
  healthEndpoint: /api/v1/health
```

Step 3: Update Deck's URL in your `SpinnakerService` config.

Add the following under the `spec.config.security` section:

```yaml
uiSecurity:
  overrideBaseUrl: https://spinnaker.example.com
```

Step 4: Update Gate's URL in your `SpinnakerService` config.

Add the following under the `spec.config.security` section:

```yaml
apiSecurity:
  overrideBaseUrl: https://spinnaker.example.com/api/v1
```

Step 5: Deploy your `SpinnakerService` config using either `kubectl` or `kustomize` command syntax
 

### Halyard Approach

Step 1: Set Gate's server servlet to be aware of its context path at `/api/v1` by creating a file named `gate-local.yml`
in the `profiles` directory.

```bash
# Make the profiles directory if it doesn't already exist

mkdir /home/spinnaker/.hal/default/profiles
```

```bash
# Make the gate-local.yml file in the profile directory

tee /home/spinnaker/.hal/default/profiles/gate-local.yml <<-'EOF'
server:
  servlet:
    context-path: /api/v1
EOF
```

Step 2: Set Gate's health endpoint to `/api/v1/health` by creating a file named `gate.yml` in the `service-settings`
directory.

```bash
# Make the service-settings directory if it doesn't already exist

mkdir /home/spinnaker/.hal/default/service-settings
```

```bash
# Make the gate-local.yml file in the profile directory

tee /home/spinnaker/.hal/default/profiles/gate-local.yml <<-'EOF'
healthEndpoint: /api/v1/health
EOF
```

Step 3: Update Deck's URL using Halyard command

```
hal config security ui edit --override-base-url https://spinnaker.example.com
```

Step 4: Update Gate's URL using Halyard command

```
hal config security api edit --override-base-url https://spinnaker.example.com/api/v1
```

Step 5: Apply the Spinnaker Configuration changes using Halyard command

```
hal deploy apply
```