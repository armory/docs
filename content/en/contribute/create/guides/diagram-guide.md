---
title: Diagram Guide
weight: 3
description: >
   Use Mermaid to create diagrams and charts in your content pages.
draft: true
---

## {{% heading "prereq" %}}

The preferred method for adding diagrams to the Armory Docs is Mermaid rather than an image (SVG, PNG, etc). Using Mermaid, you create your diagram within the Markdown page. Be sure to read the Kubernetes documentation's excellent [Diagram Guide](https://kubernetes.io/docs/contribute/style/diagram-guide/) for creating Mermaid diagrams.

Additional Mermaid resources:

* [Mermaid docs](https://mermaid-js.github.io/mermaid/#/)
* [Mermaid GitHub](https://github.com/mermaid-js/mermaid)
* The Docsy theme's [Diagrams with Mermaid](https://www.docsy.dev/docs/adding-content/lookandfeel/#diagrams-with-mermaid)

## Mermaid digram examples

### Graph example


```mermaid
 graph TB

	 deck(Deck-Armory) --> gate;
	 api(Custom Script/API Caller) --> gate(Gate);
	 gate(Gate-Armory) --> kayenta(Kayenta);
	 orca(Orca-Armory) --> kayenta(Kayenta);
	 gate --> orca;
	 gate --> clouddriver(Clouddriver);
	 orca --> clouddriver;
	 gate --> rosco(Rosco);
	 orca --> front50;
	 orca --> rosco
	 gate --> front50(Front50);
	 gate --> fiat(Fiat);
	 gate --> kayenta(Kayenta);
	 orca --> kayenta;
	 clouddriver --> fiat;
	 orca --> fiat;
	 front50 --> fiat;
	 echo(Echo-Armory) --> orca;
	 echo --> front50;
	 igor(Igor) --> echo;
	 dinghy(Dinghy) --> front50;
	 dinghy --> orca;
	 configurator(Configurator) --> S3;
	 front50 --> S3;
	 platform(Platform) --> echo;
	 platform --> orca;

 classDef default fill:#d8e8ec,stroke:#39546a;
 linkStyle default stroke:#39546a,stroke-width:1px,fill:none;

 classDef external fill:#c0d89d,stroke:#39546a;
 class deck,api external
```

<details><summary>Show me the code.</summary>
{{< highlight >}}
```mermaid
 graph TB

	 deck(Deck-Armory) --> gate;
	 api(Custom Script/API Caller) --> gate(Gate);
	 gate(Gate-Armory) --> kayenta(Kayenta);
	 orca(Orca-Armory) --> kayenta(Kayenta);
	 gate --> orca;
	 gate --> clouddriver(Clouddriver);
	 orca --> clouddriver;
	 gate --> rosco(Rosco);
	 orca --> front50;
	 orca --> rosco
	 gate --> front50(Front50);
	 gate --> fiat(Fiat);
	 gate --> kayenta(Kayenta);
	 orca --> kayenta;
	 clouddriver --> fiat;
	 orca --> fiat;
	 front50 --> fiat;
	 echo(Echo-Armory) --> orca;
	 echo --> front50;
	 igor(Igor) --> echo;
	 dinghy(Dinghy) --> front50;
	 dinghy --> orca;
	 configurator(Configurator) --> S3;
	 front50 --> S3;
	 platform(Platform) --> echo;
	 platform --> orca;

 classDef default fill:#d8e8ec,stroke:#39546a;
 linkStyle default stroke:#39546a,stroke-width:1px,fill:none;

 classDef external fill:#c0d89d,stroke:#39546a;
 class deck,api external
```
{{< /highlight >}}
</details>

### Flowchart examples

```mermaid
flowchart LR
   id0<--"REST API"-->id2
   id1<--"REST API"-->id2
   id2<--"gRPC/HTTP2"-->id3

   subgraph outside [External Environments]
   id0[Armory CD-as-a-Service CLI]
   id1[Automation Tools<br>GitHub, Jenkins, GitLab, Spinnaker]
   end

   id2{Armory<br>CD-as-a-Service}

   subgraph kubernetes [Kubernetes Cluster]
   id3[Remote Network Agent]
   end

   classDef k8s fill:#326de6,stroke:#000000,stroke-width:1px
   classDef armory fill:#38b5d9,stroke:#000000,stroke-width:1px
   classDef ext fill:#ffffff,stroke:#000000,stroke-width:1px
   class kubernetes k8s
   class id2,id3,id0 armory
   class outside ext
```

<details><summary>Show me the code.</summary>
{{< highlight >}}
```mermaid
flowchart LR
   id0<--"REST API"-->id2
   id1<--"REST API"-->id2
   id2<--"gRPC/HTTP2"-->id3

   subgraph outside [External Environments]
   id0[Armory CD-as-a-Service CLI]
   id1[Automation Tools<br>GitHub, Jenkins, GitLab, Spinnaker]
   end

   id2{Armory<br>CD-as-a-Service}

   subgraph kubernetes [Kubernetes Cluster]
   id3[Remote Network Agent]
   end

   classDef k8s fill:#326de6,stroke:#000000,stroke-width:1px
   classDef armory fill:#38b5d9,stroke:#000000,stroke-width:1px
   classDef ext fill:#ffffff,stroke:#000000,stroke-width:1px
   class kubernetes k8s
   class id2,id3,id0 armory
   class outside ext
```
{{< /highlight >}}
</details>

<br>
<br>
<br>

```mermaid
flowchart TB   
   A --> B
   B --> C
   C --> D
   D --> E
   E --> F
   F -- "Success: true" --> G
   F -- "Success: false" --> H

   A["Deployment Starts"]
   B["Webhook Call Triggered<br>Deployment Pauses"]
   F{"Did the external process<br>succeed or fail?"}
   G["Deployment Continues"]
   H["Deployment Rolls Back"]

   subgraph exp [External Process]
   C["External API<br>Receives Request"]
   D["Process Runs"]
   E[Callback to Deployment]
   end
```

<details><summary>Show me the code.</summary>
{{< highlight >}}
```mermaid
flowchart TB   
   A --> B
   B --> C
   C --> D
   D --> E
   E --> F
   F -- "Success: true" --> G
   F -- "Success: false" --> H

   A["Deployment Starts"]
   B["Webhook Call Triggered<br>Deployment Pauses"]
   F{"Did the external process<br>succeed or fail?"}
   G["Deployment Continues"]
   H["Deployment Rolls Back"]

   subgraph exp [External Process]
   C["External API<br>Receives Request"]
   D["Process Runs"]
   E[Callback to Deployment]
   end
```
{{< /highlight >}}
</details>





