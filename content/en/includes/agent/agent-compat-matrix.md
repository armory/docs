> The Armory Agent is in early access. For more information about using this feature, [contact us](https://www.armory.io/contact-us/).

The Armory Agent is compatible with Armory Enterprise and open source Spinnaker. It consists of a lightweight Agent service that you deploy on Kubernetes and a plugin that you install into Clouddriver. Your Clouddriver service must use a MySQL-compatible database. See the {{< linkWithTitle "clouddriver-sql-configure.md" >}} guide for instructions.

| Armory Enterprise (Spinnaker) Version | Armory Agent Plugin Version    | Armory Agent Version |
|:-------------------------- |:------------------------------ |:---------------------------- |
| {{<param kubesvc-plugin.agent_plug_latest_spin-2>}} | {{<param kubesvc-plugin.agent_plug_latest-2>}} | {{<param kubesvc-version>}} |
| {{<param kubesvc-plugin.agent_plug_latest_spin-1>}} | {{<param kubesvc-plugin.agent_plug_latest-1>}} | {{<param kubesvc-version>}} |
| {{<param kubesvc-plugin.agent_plug_latest_spin>}}   | {{<param kubesvc-plugin.agent_plug_latest>}}   | {{<param kubesvc-version>}} |

{{< include "db-compat.md" >}}