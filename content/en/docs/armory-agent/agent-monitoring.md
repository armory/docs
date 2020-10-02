---
title: Monitoring Armory Agent
linkTitle: Monitoring
description: >
  Guide for monitoring Armory Agent in a production environment
---

![Armory Agent reports its runtime resource metrics to Prometheus for Monitoring the health](/images/armory-agent/agent-monitoring.png)

The Armory Agent service should only consume about 4 MB of memory and a small amount of CPU. Agent resources should be monitored for production stability, especially as application deployment increase. Running as part of an Armory platform, the Armory Agents sends health information and statistics to Prometheus endpoints so you can monitor agent performance.

