---
title: Known Issues and Limitations
weight: 9999
---


## Manifest requirements

Can I get a page called something like ‘Supported deployment manifests’ or ‘deployment manifest limitations’ added to the aurora+borealis documentation? We currently do not support:
the manifest must contain exactly 1 kubernetes ‘Deployment’ object within a single deploy.yml (or project aurora spinnaker stage).
we do not support deploying replicasets
we do not support deploying pods.