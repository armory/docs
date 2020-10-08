### GCE predictive autoscaling exception

An exception occurs in the Spinnaker UI (Deck) if the GCE provider is enabled but predictive autoscaling is not enabled.

**Workaround**

Add the following property to your `settings.js`:

```js
window.spinnakerSettings.providers.gce.feature = {};
```

For more information, see this OSS Pull Request: [8585](https://github.com/spinnaker/deck/pull/8585).