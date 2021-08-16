<!--
this is an upcoming potential breaking change that will not affect everyone, so it's in its own section
-->

### Java 11.0.11+, TLS 1.1 communication failure

> This is an issue between Java 11.0.11 and TLSv1.1. Only installations using TLSv1.1 will encounter communication failures between services when those services upgrade to Java 11.0.11+.

TLSv1.1 was deprecated in March of 2020 and reached end-of-life in March of 2021. You should no longer be using TLSv1.1 for secure communication.

Oracle released Java 11.0.11 in April of 2021. Java 11.0.11 dropped support for TLSv1.1. See the Java [release notes](https://www.oracle.com/java/technologies/javase/11all-relnotes.html#JDK-8202343) for details.

**Impact**

Any services running under Java 11.0.11+ **and** using TLSv1.1 will encounter a communication failure. For example, you will see a communication failure between an Armory Enterprise service running under Java 11.0.1 and MySQL 5.7 if the MySQL driver is using TLSv1.1.

The version of Java depends on the version used by the Docker container's OS. Most Armory Enterprise services are using Alpine 3.11 or 3.12, which **does not** use Java 11.0.11. However, Alpine 3.11 is end-of-life in November of 2021, and 3.12 is end-of-life in May of 2022. There is no guarantee that Java 11.0.11+ won’t be added to those container images by some other manner. **You should modify your TLSv1.1 environment now** so you don't encounter communication failures.

**Fix**

Choose the option that best fits your environment.

1. Disable TLSv1.1 and enable TLSv1.2 (preferred):

   See Knowledge Base articles [Disabling TLS 1.1 in Spinnaker and Specifying the Protocols to be used](https://support.armory.io/support?sys_kb_id=6d38e4bfdba47c1079f53ec8f49619c2&id=kb_article_view&sysparm_rank=2&sysparm_tsqueryId=f93349771b3d385013d4fe6fdc4bcb35) and [How to fix TLS error "Reason: extension (5) should not be presented in certificate_request"](https://support.armory.io/support?sys_kb_id=e06335f11b202c1013d4fe6fdc4bcbf8&id=kb_article_view&sysparm_rank=1&sysparm_tsqueryId=3b0341771b3d385013d4fe6fdc4bcb6a).

1. Add a query parameter to the MySQL JDBC URIs:

   ```
   ?enabledTLSProtocols=TLSv1.2
   ```

   Note that this only fixes communication between Armory Enterprise and MySQL. 

   See [MySQL communication failure when using TSL1.1](https://support.armory.io/support?id=kb_article&sysparm_article=KB0010376) for more information.

