## Compatibility note

Starting in 2.26, the UI has been updated to more closely follow immutable infrastructure principles.

When you navigate to the Infrastructure tab in the UI for an application that has the Kubernetes provider configured, actions that change the Kubernetes infrastructure (such as Create or Delete), including Clusters, Load Balancers, and Firewalls, are no longer available.

### Impact

Users do not see these actions in the UI by default. You must configure the UI to display them if you want your users to be able to perform them through the UI. To write policies that control which user roles can see the UI actions and be able to use them, you must enable the actions.

### Workaround

Whether or not these actions are available in the UI is controlled by the following property in `settings-local.yml`:

```yml
window.spinnakerSettings.kubernetesAdHocInfraWritesEnabled = <boolean>;
```

> Note that disabling the UI does not completely prevent users from performing these actions. For that, you must create policies.

Set this property to `true`. Setting the value to `false` hides the buttons for all users regardless of whether you grant specific users access to the buttons through the Policy Engine.