---
title: Use a Blue/Green Deployment Strategy with Spinnaker
linkTitle: Blue/Green
description: >
  Learn how to deploy your apps from Armory Continuous Deployment or Spinnaker to Kubernetes using a blue/green deployment strategy. This strategy works with ReplicaSet and Deployment kinds.
---

## Overview of blue/green deployment

Blue/Green deployment is a technique for releasing new versions of software with minimal downtime. The basic idea is to have two identical production environments, called Blue and Green. The live traffic is routed to the Blue environment, while the new version of the software is deployed to the Green environment. Once the new version has been tested and is ready for release, the traffic is switched to the Green environment, and the Blue environment becomes available for the next release. This approach allows for quick rollbacks in case of any issues with the new version, as the previous version is still available on the Blue environment.

### Benefits

Some benefits of using the blue/green deployment strategy include:

1.**Minimal downtime**: By having two identical production environments, blue/green deployment allows for seamless switching between versions, minimizing downtime for users.
1. **Easy rollbacks**: If there are issues with the new version, it is simple to switch traffic back to the previous version, as it is still available on the blue environment.
1. **Improved testing**: By having a separate environment for testing new versions, blue/green deployment allows for more thorough testing before releasing to production.
1. **Increased reliability**: By keeping the previous version available, blue/green deployment provides a fallback option in case of unexpected issues with the new version.
1. **Parallel deployment**: Blue/Green deployment enables parallel deployment of new versions, meaning you can deploy a new version of your app while still running the previous version.
1. **Cost-effective**: Blue/Green deployment can be cost-effective as it enables using the same infrastructures for both versions of your app.

For example, you have an app called `spinnaker-app` and a corresponding service called `spinnaker-service`. The first version deployed is the blue version of your app.

{{< figure src="/images/user-guides/k8s/bg/spin-blue-start.jpg" >}}


You then need to update your app to a newer version, which become the green version. You run tests on the green version in order to check if everything is working as expected.

{{< figure src="/images/user-guides/k8s/bg/spin-blue-with-green.jpg" >}}

After checking the green version is working as expected, you switch the traffic from the blue version to the green version.

{{< figure src="/images/user-guides/k8s/bg/spin-green.jpg" >}}

Now the user uses the app version "green".

With a blue/green deployment, you can easily switch back to the blue version if you find a critical bug in the green version. 

{{< figure src="/images/user-guides/k8s/bg/spin-blue-start.jpg" >}}

## {{% heading "prereq" %}}

You should be familiar with Kubernetes workload resource kinds [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)  and [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/).

## Blue/Green deployments in Spinnaker

For blue/green deployments, Spinnaker supports using Deployment and ReplicaSet kinds.

```yaml
apiVersion: apps/v1
kind: Deployment
```

```yaml
apiVersion: apps/v1
kind: ReplicaSet
```

### Differences between a ReplicaSet and a Deployment

A ReplicaSet creates and scales pods. It also ensures that pods are running on healthy nodes. A Deployment, on the other hand, is a higher-level resource object that creates and updates ReplicaSets and pods. It provides additional functionality such as rolling updates, rollbacks, and self-healing.

In the Spinnaker UI, you can see that a Deployment resource visually contains a ReplicaSet:

{{< figure src="/images/user-guides/k8s/bg/spinui-dep-rs.png" >}}


### Benefits to using Deployments over ReplicaSets

There are several benefits to using Deployments over ReplicaSets in Kubernetes:

1. Rolling updates: Deployments allow you to perform rolling updates to your pods, which means that you can update your app without any downtime. This is done by incrementally updating the replicas in a ReplicaSet, while keeping the others running.
1. Rollbacks: Deployments also allow you to easily roll back to a previous version of your app in case of issues with an update.
1. Self-healing: Deployments can automatically detect and replace failed pods, ensuring that your app is always running the desired number of replicas.
1. Scaling: Deployments can be easily scaled up or down by changing the number of replicas defined in the Deployment manifest.
1. Versioning: Deployments allow you to maintain multiple versions of your app, each with its own desired state and update strategy.
1. Abstraction: Deployments provide a higher-level abstraction over ReplicaSets, making it easier to manage and update your app.

### Benefits to using ReplicaSets over Deployments

Benefits to using ReplicaSets over Deployments in Kubernetes are:

1. Simpler: ReplicaSets are simpler to use and understand than Deployments, as they only manage the number of replicas for a pod or set of pods. This can be useful in certain scenarios where you don't need the additional features provided by Deployments.
1. More flexibility: ReplicaSets offer more flexibility in terms of managing pods, as they don't have the additional constraints imposed by Deployments. This can be useful in scenarios where you need more fine-grained control over your pods.
1. Lower overhead: ReplicaSets have lower overhead than Deployments, as they don't have the additional logic for rolling updates, rollbacks and self-healing. This can be useful in scenarios where you have limited resources or where performance is critical.
1. Compatibility: ReplicaSets are compatible with other k8s resources such as StatefulSets and DaemonSets, while Deployment is not.

ReplicaSets are considered a building block for Deployments. For most use cases, you should use a Deployment because it provides more robust and sophisticated management capabilities.

## Create a blue/green deployment using Deployment

In this example, you use the Spinnaker UI to create a blue/green deployment for nginx. You can extend this process to create pipelines that automatically deploy your services using a blue/green strategy.

### Create a Spinnaker application and LoadBalancer

1. [Create an application](https://spinnaker.io/docs/guides/user/applications/create/).
1. Create a LoadBalancer to handle our service traffic. 

   1. Click the **LOAD BALANCERS** tab.
   1. Click the **Create Load Balancer** button. 

      {{< figure src="/images/user-guides/k8s/bg/spinui-loadbalancers.png" >}}
   1. If you have more than one provider configured, select **Kubernetes** in the **Select Your Provider** window. Then click **Next**.
   1. In the **Deploy Manifest** window, select your Kubernetes account from the **Account** list. Then add the following in the **Manifest** text box:

      ```yaml
      apiVersion: v1
      kind: Service
      metadata:
        name: nginx
      spec:
        ports:
          - port: 80
            protocol: TCP
	      selector:
		      name: nginx
        type: LoadBalancer
      ```
      
      Press the **Create** button.
      {{< figure src="/images/user-guides/k8s/bg/Untitled%202.png" >}}

   1. Wait for service creation to complete. Then verify the LoadBalancer has been created.
      
      {{< figure src="/images/user-guides/k8s/bg/Untitled%203.png" >}}
      {{< figure src="/images/user-guides/k8s/bg/Untitled%204.png" >}}

### Create the blue deployment

Create a server group for your blue deployment. 

1. Click the **CLUSTERS** tab.
1. Click the **Create Server Group** button. 

   {{< figure src="/images/user-guides/k8s/bg/Untitled%205.png" >}}

1. If you have more than one provider configured, select **Kubernetes** in the **Select Your Provider** window. Then click **Next**.
1. In the **Deploy Manifest** window, select your Kubernetes account from the **Account** list. 

    Add a ConfigMap that includes a custom `index.html` for the blue version of the app. Then in the deployment config, add a volume mount for the default nginx `index.html`, which is replaced by the custom index page defined in the ConfigMap.

    Add the following in the **Manifest** text box:

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: blue-index-html
    data:
      index.html: |
        <html>
        <body bgcolor=blue>
        <marquee behavior=alternate>
        <font face=arial size=6 color=white>
        !!! Welcome to Nginx Blue Deployment !!!
        </font>
        </marquee>
        </body>
        </html>

    ---

    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      replicas: 2
      selector:
        matchLabels:
          app: nginx
      template:
        metadata:
          labels:
            app: nginx
            version: blue
        spec:
          containers:
          - name: nginx
            image: nginx:latest
            ports:
            - containerPort: 80
            volumeMounts:
            - mountPath: /usr/share/nginx/html/index.html # mount index.html to /usr/share/nginx/html/index.html
              subPath: index.html
              readOnly: true
              name: index-html
          volumes:
          - name: index-html
            configMap:
              name: blue-index-html # place ConfigMap `index-html` on /usr/share/nginx/html/index.html
              items:
                - key: index.html
                  path: index.html
    ```

    The Deployment is created in the current namespace. To specify a namespace, you can add `namespace: ${account}` in the `metadata` section. For example:

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: nginx-deployment
      namespace: ${account}
    ```

    Press the **Create** button.
    {{< figure src="/images/user-guides/k8s/bg/Untitled%206.png" >}}


<br><br>

You can verify the resource creation using `kubectl` or a cluster visualizer like [Lens](https://k8slens.dev/).

{{< figure src="/images/user-guides/k8s/bg/Untitled%208.png" >}}

{{< figure src="/images/user-guides/k8s/bg/Untitled%209.png" >}}


You should see your deployment the LoadBalancer attached.

{{< figure src="/images/user-guides/k8s/bg/Untitled%2010.png" >}}


When you click in the LoadBalancer icon, a tab opens. Click the **Ingress** URL to open a browser window to the deployment.

{{< figure src="/images/user-guides/k8s/bg/Untitled%2011.png" >}}


You should see the blue deployment page.

{{< figure src="/images/user-guides/k8s/bg/Untitled%2012.png" >}}


### Create the green deployment

1. Click the **CLUSTERS** tab.
1. Click the **Create Server Group** button. 
1. If you have more than one provider configured, select **Kubernetes** in the **Select Your Provider** window. Then click **Next**.
1. In the **Deploy Manifest** window, select your Kubernetes account from the **Account** list.  Add the following in the **Manifest** text box:

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: green-index-html
    data:
      index.html: |
        <html>
        <body bgcolor=green>
        <marquee behavior=alternate>
        <font face=arial size=6 color=white>
        !!! Welcome to Nginx Green Deployment !!!
        </font>
        </marquee>
        </body>
        </html>

    ---

    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: nginx-deployment
      annotations:
        traffic.spinnaker.io/load-balancers: '["service nginx"]'
    spec:
      selector:
        matchLabels:
          app: nginx
      replicas: 2 # tells deployment to run 2 pods matching the template
      template:
        metadata:
          labels:
            app: nginx
            version: green
        spec:
          containers:
          - name: nginx
            image: nginx:1.14.2
            ports:
            - containerPort: 80
            volumeMounts:
            - mountPath: /usr/share/nginx/html/index.html # mount index.html to /usr/share/nginx/html/index.html
              subPath: index.html
              readOnly: true
              name: index-html
          volumes:
          - name: index-html
            configMap:
              name: green-index-html # place ConfigMap `index-html` on /usr/share/nginx/html/index.html
              items:
                - key: index.html
                  path: index.html
    ```

    Press the **Create** button.

<br><br>
Refresh the Spinnaker UI page. You should see the new version listed inside your deployment and also how the LoadBalancer is transferring the network traffic to the green version.

{{< figure src="/images/user-guides/k8s/bg/Untitled%2014.png" >}}


If the deployment is successful, the green version has 100% of the resources.
{{< figure src="/images/user-guides/k8s/bg/Untitled%2015.png" >}}


If you go to our previous ingress url, we gonna see the new version deployed
{{< figure src="/images/user-guides/k8s/bg/Untitled%2016.png" >}}


If something goes wrong with new version, LoadBalancer will point again to blue version. If the deployment is completed successfully, but you can rollback to the last version, you can go to CLUSTERS section, select the deployment, click in Deployment Action, and click in Undo Rollout, select previous revision and submit the request.
{{< figure src="/images/user-guides/k8s/bg/Untitled%2017.png" >}}

{{< figure src="/images/user-guides/k8s/bg/Untitled%2018.png" >}}


If we go back to the app ingress url, we have again the blue deployment
{{< figure src="/images/user-guides/k8s/bg/Untitled%2019.png" >}}


Congrats! you achieved a blue/green deployment successfully. Now we can translate all previous steps in a pipeline to automatize this process for any new release/deployment

## Create a blue/green deployment using ReplicaSet

The process to execute a blue/green deployment is pretty similar to use directly Deployment, basically we gonna use explicitly the ReplicaSet resource in our manifests. As we explained before Deployment is a high abstraction of ReplicaSets.

So lets start, creating an app and going to LOAD BALANCERS section to create our loadbalancer resource to allow us handle the network and expose our app.
{{< figure src="/images/user-guides/k8s/bg/Untitled%2020.png" >}}


```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx
spec:
  ports:
    - port: 80
      protocol: TCP
  type: LoadBalancer
```

Wait until complete, and you will be able to see our resource in LOAD BALANCERS screen
{{< figure src="/images/user-guides/k8s/bg/Untitled%2021.png" >}}


Now, let’s go to create our app with blue version, only using ReplicaSet resource. Go to CLUSTERS section and click on Create Server Group action
{{< figure src="/images/user-guides/k8s/bg/Untitled%2022.png" >}}

{{< figure src="/images/user-guides/k8s/bg/Untitled%2023.png" >}}


```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: blue-index-html
data:
  index.html: |
    <html>
    <body bgcolor=blue>
    <marquee behavior=alternate>
    <font face=arial size=6 color=white>
    !!! Welcome to Nginx Blue Deployment !!!
    </font>
    </marquee>
    </body>
    </html>

---

apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: nginx-replicaset
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
      version: blue
  template:
    metadata:
      labels:
        app: nginx
        version: blue
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
        volumeMounts:
        - mountPath: /usr/share/nginx/html/index.html # mount index.html to /usr/share/nginx/html/index.html
          subPath: index.html
          readOnly: true
          name: index-html
      volumes:
      - name: index-html
        configMap:
          name: blue-index-html # place ConfigMap `index-html` on /usr/share/nginx/html/index.html
          items:
            - key: index.html
              path: index.html
```

Note: Again, first we added a ConfigMap to allow us create a html view and let us exemplify in a visual way our app versioned. Then with volumeMount we shared the nginx default index.html, and later is replaced with our ConfigMap.

This time we need redirect our LoadBalancer manually. Let’s go to our LoadBalancer, click on it, click in “Service Actions” and edit
{{< figure src="/images/user-guides/k8s/bg/Untitled%2024.png" >}}


In manifest edit window, add the selector section at final for our app and our version, in this case “app: nginx”, “version: blue”
{{< figure src="/images/user-guides/k8s/bg/Untitled%2025.png" >}}


Now, we are able to see the resource assigned to our loadBalancer, and if we click in the LoadBalancer icon, a sidebar with ingress url will be displayed, click on it and we gonna see our app deployed successfully
{{< figure src="/images/user-guides/k8s/bg/Untitled%2026.png" >}}

{{< figure src="/images/user-guides/k8s/bg/Untitled%2027.png" >}}


Here we have a difference with deployment resource. If we go to check our cluster resources, and you look for Deployments resource, we don’t gonna see any “nginx” resource, but replicaset resource will contain our resource:
{{< figure src="/images/user-guides/k8s/bg/Untitled%2028.png" >}}


Now, proceed to deploy our green version over our replicaSet resource, again going to CLUSTERS section,

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: green-index-html
data:
  index.html: |
    <html>
    <body bgcolor=green>
    <marquee behavior=alternate>
    <font face=arial size=6 color=white>
    !!! Welcome to Nginx Green Deployment !!!
    </font>
    </marquee>
    </body>
    </html>

---

apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: nginx-replicaset
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
      version: green
  template:
    metadata:
      labels:
        app: nginx
        version: green
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
        volumeMounts:
        - mountPath: /usr/share/nginx/html/index.html # mount index.html to /usr/share/nginx/html/index.html
          subPath: index.html
          readOnly: true
          name: index-html
      volumes:
      - name: index-html
        configMap:
          name: green-index-html # place ConfigMap `index-html` on /usr/share/nginx/html/index.html
          items:
            - key: index.html
              path: index.html
```

Now, our replicaSet resource will display the new version, with new pods create, but LoadBalancer is still pointing to blue version.
{{< figure src="/images/user-guides/k8s/bg/Untitled%2029.png" >}}


Now go again to our LoadBalancer, click on it, service actions, and change the version selector parameter to green
{{< figure src="/images/user-guides/k8s/bg/Untitled%2030.png" >}}


If we go to our ingress url, we gonna see our green version displayed!
{{< figure src="/images/user-guides/k8s/bg/Untitled%2031.png" >}}


If we want rollback, just point the LoadBalancer to blue version editing again the selector, and delete the green replicaset created.

If green version is working as expected, finally, go back to CLUSTERS section, and we can delete the blue version replicaSet resource that is running
{{< figure src="/images/user-guides/k8s/bg/Untitled%2032.png" >}}


## Blue/Green Deployment from a pipeline

Create a pipeline, in configuration pipeline, go to “Pipeline Actions”, and click in “Edit as JSON”, paste:

```json
{
  "keepWaitingPipelines": false,
  "lastModifiedBy": "anonymous",
  "limitConcurrent": true,
  "parameterConfig": [
    {
      "default": "",
      "description": "Select deployment",
      "hasOptions": true,
      "label": "",
      "name": "deployment",
      "options": [
        {
          "value": "blue"
        },
        {
          "value": "green"
        }
      ],
      "pinned": false,
      "required": true
    }
  ],
  "schema": "1",
  "spelEvaluator": "v4",
  "stages": [
    {
      "account": "spinnaker",
      "cloudProvider": "kubernetes",
      "manifests": [
        {
          "apiVersion": "v1",
          "data": {
            "index.html": "<html>\n<body bgcolor=blue>\n<marquee behavior=alternate>\n<font face=arial size=6 color=white>\n!!! Welcome to Nginx Blue Deployment !!!\n</font>\n</marquee>\n</body>\n</html>\n"
          },
          "kind": "ConfigMap",
          "metadata": {
            "name": "blue-index-html"
          }
        },
        {
          "apiVersion": "apps/v1",
          "kind": "Deployment",
          "metadata": {
            "name": "nginx-deployment"
          },
          "spec": {
            "replicas": 2,
            "selector": {
              "matchLabels": {
                "app": "nginx"
              }
            },
            "template": {
              "metadata": {
                "labels": {
                  "app": "nginx",
                  "version": "blue"
                }
              },
              "spec": {
                "containers": [
                  {
                    "image": "nginx:1.14.2",
                    "name": "nginx",
                    "ports": [
                      {
                        "containerPort": 80
                      }
                    ],
                    "volumeMounts": [
                      {
                        "mountPath": "/usr/share/nginx/html/index.html",
                        "name": "index-html",
                        "readOnly": true,
                        "subPath": "index.html"
                      }
                    ]
                  }
                ],
                "volumes": [
                  {
                    "configMap": {
                      "items": [
                        {
                          "key": "index.html",
                          "path": "index.html"
                        }
                      ],
                      "name": "blue-index-html"
                    },
                    "name": "index-html"
                  }
                ]
              }
            }
          }
        }
      ],
      "moniker": {
        "app": "nginx"
      },
      "name": "Blue Deployment",
      "refId": "1",
      "requisiteStageRefIds": [
        "3"
      ],
      "skipExpressionEvaluation": false,
      "source": "text",
      "trafficManagement": {
        "enabled": true,
        "options": {
          "enableTraffic": true,
          "namespace": "your-namespace",
          "services": [
            "service nginx"
          ],
          "strategy": "redblack"
        }
      },
      "type": "deployManifest"
    },
    {
      "completeOtherBranchesThenFail": false,
      "continuePipeline": false,
      "failPipeline": true,
      "name": "Check If Blue",
      "preconditions": [
        {
          "context": {
            "expression": "${parameters.deployment.equals('blue')}"
          },
          "failPipeline": false,
          "type": "expression"
        }
      ],
      "refId": "3",
      "requisiteStageRefIds": [
        "6"
      ],
      "restrictExecutionDuringTimeWindow": false,
      "type": "checkPreconditions"
    },
    {
      "failOnFailedExpressions": false,
      "name": "Check If Green",
      "preconditions": [
        {
          "context": {
            "expression": "${parameters.deployment.equals('green')}"
          },
          "failPipeline": false,
          "type": "expression"
        }
      ],
      "refId": "4",
      "requisiteStageRefIds": [
        "6"
      ],
      "type": "checkPreconditions"
    },
    {
      "account": "spinnaker",
      "cloudProvider": "kubernetes",
      "manifests": [
        {
          "apiVersion": "v1",
          "data": {
            "index.html": "<html>\n<body bgcolor=green>\n<marquee behavior=alternate>\n<font face=arial size=6 color=white>\n!!! Welcome to Nginx Green Deployment !!!\n</font>\n</marquee>\n</body>\n</html>\n"
          },
          "kind": "ConfigMap",
          "metadata": {
            "name": "green-index-html"
          }
        },
        {
          "apiVersion": "apps/v1",
          "kind": "Deployment",
          "metadata": {
            "name": "nginx-deployment"
          },
          "spec": {
            "replicas": 2,
            "selector": {
              "matchLabels": {
                "app": "nginx"
              }
            },
            "template": {
              "metadata": {
                "labels": {
                  "app": "nginx",
                  "version": "green"
                }
              },
              "spec": {
                "containers": [
                  {
                    "image": "nginx:1.14.2",
                    "name": "nginx",
                    "ports": [
                      {
                        "containerPort": 80
                      }
                    ],
                    "volumeMounts": [
                      {
                        "mountPath": "/usr/share/nginx/html/index.html",
                        "name": "index-html",
                        "readOnly": true,
                        "subPath": "index.html"
                      }
                    ]
                  }
                ],
                "volumes": [
                  {
                    "configMap": {
                      "items": [
                        {
                          "key": "index.html",
                          "path": "index.html"
                        }
                      ],
                      "name": "green-index-html"
                    },
                    "name": "index-html"
                  }
                ]
              }
            }
          }
        }
      ],
      "moniker": {
        "app": "nginx"
      },
      "name": "Green Deployment",
      "refId": "5",
      "requisiteStageRefIds": [
        "4"
      ],
      "skipExpressionEvaluation": false,
      "source": "text",
      "trafficManagement": {
        "enabled": true,
        "options": {
          "enableTraffic": true,
          "namespace": "your-namespace",
          "services": [
            "service nginx"
          ],
          "strategy": "redblack"
        }
      },
      "type": "deployManifest"
    },
    {
      "account": "spinnaker",
      "cloudProvider": "kubernetes",
      "manifests": [
        {
          "apiVersion": "v1",
          "kind": "Service",
          "metadata": {
            "name": "nginx"
          },
          "spec": {
            "ports": [
              {
                "port": 80,
                "protocol": "TCP"
              }
            ],
            "selector": {
              "name": "nginx"
            },
            "type": "LoadBalancer"
          }
        }
      ],
      "moniker": {
        "app": "nginx"
      },
      "name": "Create LoadBalancer",
      "refId": "6",
      "requisiteStageRefIds": [],
      "skipExpressionEvaluation": false,
      "source": "text",
      "trafficManagement": {
        "enabled": false,
        "options": {
          "enableTraffic": false,
          "services": []
        }
      },
      "type": "deployManifest"
    }
  ],
  "triggers": []
}
```

Now, let’s see the pipeline
{{< figure src="/images/user-guides/k8s/bg/Untitled%2033.png" >}}


- In configuration stage, we added a parameter where we can select the version to be deployed between green or blue app
{{< figure src="/images/user-guides/k8s/bg/Untitled%2034.png" >}}

{{< figure src="/images/user-guides/k8s/bg/Untitled%2035.png" >}}


Then we have the creation of our LoadBalancer if not exists to be used in the deployment stages to handle the network traffic.

Next stages will check if green or blue deployment was selected

Finally we have the deploy for blue or green version, if we take a look in each stage, we can see that we can configure directly the strategy and select the loadbalancer to cutover our blue or green box if the deployment is successful, if fails, it will rollback automatically.
{{< figure src="/images/user-guides/k8s/bg/Untitled%2036.png" >}}


Note: If you take a look in the manifests for each Manifest Deployment stage type, you can see the same manifests that we used previously creating each piece, step by step.

Let us execute, and deploy the green app version
{{< figure src="/images/user-guides/k8s/bg/Untitled%2037.png" >}}

{{< figure src="/images/user-guides/k8s/bg/Untitled%2038.png" >}}


Going to same url, where we deployed blue version previously
{{< figure src="/images/user-guides/k8s/bg/Untitled%2039.png" >}}


If the deployment is completed successfully, but you can rollback to the last version, you can go to CLUSTERS section, select the deployment, click in Deployment Action, and click in Undo Rollout, select previous revision and submit the request. Or just re-deploy the blue deployment over green.


{{< figure src="/images/user-guides/k8s/bg/Untitled%2040.png" >}}


The next JSON is to use ReplicaSets instead deployments:

```json
{
  "appConfig": {},
  "keepWaitingPipelines": false,
  "lastModifiedBy": "anonymous",
  "limitConcurrent": true,
  "parameterConfig": [
    {
      "default": "",
      "description": "Select deployment",
      "hasOptions": true,
      "label": "",
      "name": "deployment",
      "options": [
        {
          "value": "blue"
        },
        {
          "value": "green"
        }
      ],
      "pinned": false,
      "required": true
    }
  ],
  "schema": "1",
  "spelEvaluator": "v4",
  "stages": [
    {
      "account": "spinnaker",
      "cloudProvider": "kubernetes",
      "manifests": [
        {
          "apiVersion": "v1",
          "data": {
            "index.html": "<html>\n<body bgcolor=blue>\n<marquee behavior=alternate>\n<font face=arial size=6 color=white>\n!!! Welcome to Nginx Blue Deployment !!!\n</font>\n</marquee>\n</body>\n</html>\n"
          },
          "kind": "ConfigMap",
          "metadata": {
            "name": "blue-index-html"
          }
        },
        {
          "apiVersion": "apps/v1",
          "kind": "ReplicaSet",
          "metadata": {
            "name": "nginx-replicaset"
          },
          "spec": {
            "replicas": 3,
            "selector": {
              "matchLabels": {
                "app": "nginx",
                "version": "blue"
              }
            },
            "template": {
              "metadata": {
                "labels": {
                  "app": "nginx",
                  "version": "blue"
                }
              },
              "spec": {
                "containers": [
                  {
                    "image": "nginx:1.14.2",
                    "name": "nginx",
                    "ports": [
                      {
                        "containerPort": 80
                      }
                    ],
                    "volumeMounts": [
                      {
                        "mountPath": "/usr/share/nginx/html/index.html",
                        "name": "index-html",
                        "readOnly": true,
                        "subPath": "index.html"
                      }
                    ]
                  }
                ],
                "volumes": [
                  {
                    "configMap": {
                      "items": [
                        {
                          "key": "index.html",
                          "path": "index.html"
                        }
                      ],
                      "name": "blue-index-html"
                    },
                    "name": "index-html"
                  }
                ]
              }
            }
          }
        }
      ],
      "moniker": {
        "app": "nginx"
      },
      "name": "Blue Deployment",
      "refId": "1",
      "requisiteStageRefIds": [
        "3"
      ],
      "skipExpressionEvaluation": false,
      "source": "text",
      "trafficManagement": {
        "enabled": true,
        "options": {
          "enableTraffic": true,
          "namespace": "your-namespace",
          "services": [
            "service nginx"
          ],
          "strategy": "redblack"
        }
      },
      "type": "deployManifest"
    },
    {
      "completeOtherBranchesThenFail": false,
      "continuePipeline": false,
      "failPipeline": true,
      "name": "Check If Blue",
      "preconditions": [
        {
          "context": {
            "expression": "${parameters.deployment.equals('blue')}"
          },
          "failPipeline": false,
          "type": "expression"
        }
      ],
      "refId": "3",
      "requisiteStageRefIds": [
        "6"
      ],
      "restrictExecutionDuringTimeWindow": false,
      "type": "checkPreconditions"
    },
    {
      "failOnFailedExpressions": false,
      "name": "Check If Green",
      "preconditions": [
        {
          "context": {
            "expression": "${parameters.deployment.equals('green')}"
          },
          "failPipeline": false,
          "type": "expression"
        }
      ],
      "refId": "4",
      "requisiteStageRefIds": [
        "6"
      ],
      "type": "checkPreconditions"
    },
    {
      "account": "spinnaker",
      "cloudProvider": "kubernetes",
      "manifests": [
        {
          "apiVersion": "v1",
          "data": {
            "index.html": "<html>\n<body bgcolor=green>\n<marquee behavior=alternate>\n<font face=arial size=6 color=white>\n!!! Welcome to Nginx Green Deployment !!!\n</font>\n</marquee>\n</body>\n</html>\n"
          },
          "kind": "ConfigMap",
          "metadata": {
            "name": "green-index-html"
          }
        },
        {
          "apiVersion": "apps/v1",
          "kind": "ReplicaSet",
          "metadata": {
            "name": "nginx-replicaset"
          },
          "spec": {
            "replicas": 3,
            "selector": {
              "matchLabels": {
                "app": "nginx",
                "version": "green"
              }
            },
            "template": {
              "metadata": {
                "labels": {
                  "app": "nginx",
                  "version": "green"
                }
              },
              "spec": {
                "containers": [
                  {
                    "image": "nginx:1.14.2",
                    "name": "nginx",
                    "ports": [
                      {
                        "containerPort": 80
                      }
                    ],
                    "volumeMounts": [
                      {
                        "mountPath": "/usr/share/nginx/html/index.html",
                        "name": "index-html",
                        "readOnly": true,
                        "subPath": "index.html"
                      }
                    ]
                  }
                ],
                "volumes": [
                  {
                    "configMap": {
                      "items": [
                        {
                          "key": "index.html",
                          "path": "index.html"
                        }
                      ],
                      "name": "green-index-html"
                    },
                    "name": "index-html"
                  }
                ]
              }
            }
          }
        }
      ],
      "moniker": {
        "app": "nginx"
      },
      "name": "Green Deployment",
      "refId": "5",
      "requisiteStageRefIds": [
        "4"
      ],
      "skipExpressionEvaluation": false,
      "source": "text",
      "trafficManagement": {
        "enabled": true,
        "options": {
          "enableTraffic": true,
          "namespace": "your-namespace",
          "services": [
            "service nginx"
          ],
          "strategy": "redblack"
        }
      },
      "type": "deployManifest"
    },
    {
      "account": "spinnaker",
      "cloudProvider": "kubernetes",
      "manifests": [
        {
          "apiVersion": "v1",
          "kind": "Service",
          "metadata": {
            "name": "nginx"
          },
          "spec": {
            "ports": [
              {
                "port": 80,
                "protocol": "TCP"
              }
            ],
            "selector": {
              "name": "nginx"
            },
            "type": "LoadBalancer"
          }
        }
      ],
      "moniker": {
        "app": "nginx"
      },
      "name": "Create LoadBalancer",
      "refId": "6",
      "requisiteStageRefIds": [],
      "skipExpressionEvaluation": false,
      "source": "text",
      "trafficManagement": {
        "enabled": false,
        "options": {
          "enableTraffic": false,
          "services": []
        }
      },
      "type": "deployManifest"
    }
  ],
  "triggers": []
}
```