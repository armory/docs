#### Failing health checks when using dynamic accounts 
<!-- BOB-30122 -->

There is a known issue where the health checks for the Clouddriver pod fail when the following conditions are true:

* Spinnaker is configured to use Spring Cloud Config Dynamic Accounts backed by Vault using a K/V Secrets Engine v2.
* Spinnaker is configured to use Armory Vault Secrets.

The health check failure prevents Kubernetes from transitioning the Clouddriver pod to a ready and active state, which prevents Kubernetes from passing traffic to the Clouddriver pod.

There is currently no workaround.

**Affected versions**: 2.23.x, 2.24.x