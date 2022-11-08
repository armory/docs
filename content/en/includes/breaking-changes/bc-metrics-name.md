### Spinnaker metrics

Metrics data, specifically the metric names, for Spinnaker changed. These changes are not backwards compatible and may result in broken third-party dashboards, such as Grafana dashboards.

**Workarounds**:

* **Observability Plugin**: Armory is working on updates to the [Observability Plugin](https://github.com/armory-plugins/armory-observability-plugin) to remedy this issue. The plugin currently supports New Relic & Prometheus. Note that this resolution requires you to make updates to use the new metric names.

   For information about how to configure the Observability Plugin, see [Monitoring Spinnaker with Prometheus]({{< ref "prometheus-monitoring" >}}).

   For information about how to install a plugin, see Spinnaker's [Plugin Users Guide](https://spinnaker.io/docs/guides/user/plugins-users/).

* **Update existing dashboards**: Change your dashboards and alerts to use the new metric names.

Although both workarounds involve updating your dashboards to use the new metric names, Armory recommends switching to the Observability plugin. Due to changes the Spinnaker project is making, the Observability plugin provides a long-term solution.

**Affected versions**: Armory 2.20.x or later (OSS 1.20.x)

