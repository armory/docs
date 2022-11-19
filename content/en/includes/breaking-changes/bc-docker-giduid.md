### Spinnaker Dockerfile GID/UID changes

The Dockerfile of each Spinnaker microservice (except Halyard and Deck) now specifies an explicit GID and UID (10111) for the `spinnaker user`.

**Impact**

This breaking change affects you if you rely on the previous non-deterministically assigned GID and UID. For example, this might have been the case in a custom Kubernetes security context.

**Introduced in**: Armory 2.22
