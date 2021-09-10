#### Kubernetes infrastructure in the UI

Starting in 2.26, the UI has been updated to more closely follow immutable infrastructure principles.

When you navigate to the **Infrastructure** tab in the UI for an application that has the Kubernetes provider configured, actions that change the Kubernetes infrastructure (such as **Create** or **Delete**), including Clusters, Load Balancers, and Firewalls, are no longer available.

**Impact**

Users do not see these actions in the UI by default. You must configure the UI to display them if you want your users to be able to perform them through the UI.

**Workaround**

Whether or not these actions are available in the UI is controlled by the following property in `settings-local.yml`:

```yaml
window.spinnakerSettings.kubernetesAdHocInfraWritesEnabled = <boolean>;
```

This setting does not completely prevent users from modifying Kubernetes infrastructure through Armory Enterprise. To do so, you must use the Policy Engine and write policies using the `spinnaker.http.authz` package.

If you use the Policy Engine to control which user roles can see the UI actions and be able to use them, you must set this property to `true`. Setting the value to `false` hides the buttons for all users regardless of whether you grant specific users access to the buttons through the Policy Engine.

This property affects Kubernetes infrastructure only. The behavior is slightly different depending on if the application has only the Kubernetes provider configured or Kubernetes and other providers, such as AWS.

If the application only has the Kubernetes provider configured, the following applies:

- When set to `true`, this property causes the UI to function as it did in previous releases. This allows people to manually create and delete Kubernetes infrastructure from the UI.
- When set to `false`, this property causes the actions to be unavailable to users. This prevents users from manually creating and deleting Kubernetes infrastructure from the UI. The users can still view the infrastructure but cannot make changes through the UI.

If the application includes Kubernetes and other providers, the following applies:

- When set to `true`, this property causes the UI to function as it did in previous releases. This allows people to manually create and delete Kubernetes infrastructure from the UI. Users can continue to select whether they want to create Kubernetes or other infrastructure in the UI.
- When set to `false`, this property causes Kubernetes to be unavailable as an option when trying to modify infrastructure from the UI. Users can still make changes to infrastructure for the application from cloud providers, such as AWS, but not Kubernetes.



**Introduced in**: Armory 2.26.0