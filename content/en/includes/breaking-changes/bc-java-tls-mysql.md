<!--
this is an upcoming potential breaking change that will not affect everyone, so it's in its own section
-->

### Java 11.0.11+, TLS 1.1 communication failure

TLSv1.1 was deprecated in March of 2020 and reached end-of-life in March of 2021. You should not use TLS 1.1 for secure communication.

Java 11.0.11 dropped support for TLSv1.1.

**Impact**

Any services running under Java 11.0.11+ **and** using TLSv1.1 will encounter a communication failure. For example, you will see a communication failure between a Spinnaker service running under Java 11.0.1 and MySQL 5.7 if the MySQL driver is using TLSv1.1.

The version of Java depends on the version used by the Docker container's OS. Most Armory Enterprise services are using Alpine 3.11 or 3.12, which **does not** use Java 11.0.11. However, Alpine 3.11 is end-of-life in November of 2021, and 3.12 is end-of-life in May of 2022. There is no guarantee that Java 11.0.11+ won’t be added to those container images by some other manner. **You should modify your environment now** so you don't encounter communication failures.

**Fix**

Choose the option that best fits your environment.

1. Disable TLSv1.1 and enable TLSv1.2 (preferred):

   See Knowledge Base articles [Disabling TLS 1.1 in Spinnaker and Specifying the Protocols to be used](https://support.armory.io/support?sys_kb_id=6d38e4bfdba47c1079f53ec8f49619c2&id=kb_article_view&sysparm_rank=2&sysparm_tsqueryId=f93349771b3d385013d4fe6fdc4bcb35) and [How to fix TLS error "Reason: extension (5) should not be presented in certificate_request"](https://support.armory.io/support?sys_kb_id=e06335f11b202c1013d4fe6fdc4bcbf8&id=kb_article_view&sysparm_rank=1&sysparm_tsqueryId=3b0341771b3d385013d4fe6fdc4bcb6a).

1. Add a query parameter to the MySQL JDBC URIs:

   ```
   ?enabledTLSProtocols=TLSv1.2
   ```

   Note that this only fixes Spinnaker-MySQL communication.

   See [MySQL communication failure when using TSL1.1](https://support.armory.io/support?id=kb_article&sysparm_article=KB0010376) for more information.

