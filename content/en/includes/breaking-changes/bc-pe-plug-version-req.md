#### Policy Engine Plugin version compatibility

If you use the Policy Engine Plugin, do not upgrade to 2.27.1. Current Policy Engine Plugin releases (v.0.1.6 and lower) are not compatible with 2.27.1. The plugin can cause issues where some of the Armory Enterprise services fail to start with a `NoClassDefFoundError` error.

This issue does not affect the Policy Engine extension project, which is deprecated.

Do not upgrade to 2.27.x until a new Policy Engine Plugin release is available for download. You can track Policy Engine Plugin releases in the [repo](https://github.com/armory-plugins/policy-engine-releases/releases).
