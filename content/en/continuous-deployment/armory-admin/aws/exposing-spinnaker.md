---
title: Expose Spinnaker on AWS EKS
linkTitle: Expose Spinnaker on EKS
aliases:
  - /spinnaker/configure_ingress/
  - /spinnaker/exposing_spinnaker/
  - /docs/spinnaker/exposing-spinnaker/
  - /docs/armory-admin/exposing-spinnaker/
  - /armory-admin/exposing-spinnaker/
description: >
  Learn how to expose Spinnaker by using a public load balancer.
---

## DNS Preparation

In this tutorial, you set up two CNAME entries in your DNS. You
won't be able to actually configure the DNS until you get an A record from AWS
after creating the LoadBalancer, but you need to select the names in order to
configure the LoadBalancer. This example uses `demo.armory.io`
to be the Deck service (the UI), and `gate.demo.armory.io` to be the Gate
service (the API).

## Exposing Armory on EKS with a public Load Balancer

### Create a LoadBalancer service

While there are many ways to expose Armory, we find the method described in this post to be the easiest way to get started. If your organization has other requirements, this post may be helpful as you start working through the process.

Update your `SpinnakerService` manifest with the following example `expose` configuration, which will automatically create one Kubernetes service LoadBalancer for the API (Gate) and one for the UI (Deck):

```yaml
apiversion: spinnaker.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  ...  # rest of config omitted for brevity
  expose:
    type: service
    service:
      type: LoadBalancer
```

Save and apply the configuration. After some time, you can see the LoadBalancer CNAMEs that were created:

```bash
NAMESPACE={spinnaker namespace}
API_URL=$(kubectl -n $NAMESPACE get spinsvc spinnaker -o jsonpath='{.status.apiUrl}')
UI_URL=$(kubectl -n $NAMESPACE get spinsvc spinnaker -o jsonpath='{.status.uiUrl}')
```

### Secure with SSL on EKS

This tutorial presumes you've already created a certificate in the [AWS Certificate Manager](https://aws.amazon.com/certificate-manager/).

Update and apply the `SpinnakerService` manifest to specify the DNS names for Gate and Deck, and to provide annotations specific for EKS LoadBalancers:

```yaml
apiversion: spinnaker.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      security:
        apiSecurity:
          overrideBaseUrl: https://spinnaker-gate.armory.io  # Specify your DNS name for Gate with https scheme
        uiSecurity:
          overrideBaseUrl: https://spinnaker.armory.io       # Specify your DNS name for Deck with https scheme
        ...  # rest of config omitted for brevity
  expose:
    type: service
    service:
      type: LoadBalancer
      annotations:
        service.beta.kubernetes.io/aws-load-balancer-backend-protocol: http
        service.beta.kubernetes.io/aws-load-balancer-ssl-cert: <ACM CERT ARN>  # Replace with your cert ARN
        service.beta.kubernetes.io/aws-load-balancer-ssl-ports: 80,443
```

Assuming that Armory is installed in `spinnaker` namespace:

```bash
kubectl -n spinnaker apply -f spinnakerservice.yml
```

### Enabling sticky sessions

If your Armory installation will be using authentication and you expect to scale the API server (Gate) beyond more than one instance you'll want to enable sticky sessions. This will ensure that clients will connect and authenticate with the same server each time. Otherwise, you may be forced to reauthenticate if you get directed to a new server. To enable sticky sessions, you'll want to enable session affinity on the Gate service created above.

```bash
GATE_SVC=<spin-gate/spin-gate-public>  # spin-gate
kubectl -n ${NAMESPACE} patch service/$GATE_SVC --patch '{"spec": {"sessionAffinity": "ClientIP"}}'
```

For more details about session affinity, see the Kubernetes documentation on [Services](https://kubernetes.io/docs/concepts/services-networking/service/).

## Exposing Armory on EKS with an internal Load balancer

In this option the goal is to use AWS ALB's of type `internal` for exposing Armory only within an organization's private VPC. This consists of 3 steps: configuring Kubernetes services of type `NodePort`, creating AWS internal ALB's and updating Armory with final DNS names.

### Step 1: Create Kubernetes NodePort services

A `NodePort` Kubernetes service opens the same port (automatically chosen) on all EKS worker nodes, and forwards requests to internal pods. In this case we'll be creating two services: one for Deck (Armory's UI) and one for Gate (Armory's API).

```yaml
apiversion: spinnaker.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  ...  # rest of config omitted for brevity
  expose:
    type: service
    service:
      type: NodePort
      ...  # rest of config omitted for brevity
```

Assuming that Armory is installed in `spinnaker` namespace:

```bash
kubectl -n spinnaker apply -f spinnakerservice.yml
```

After a few seconds you can view which ports were opened in EKS worker nodes, you'll need them in the next step:

```bash
DECK_PORT=$(kubectl get service spin-deck -o jsonpath='{.spec.ports[0].nodePort}')
GATE_PORT=$(kubectl get service spin-gate -o jsonpath='{.spec.ports[0].nodePort}')
```

### Step 2: Create AWS internal load balancers

We'll describe how to create these load balancers from AWS console, but you can use any preferred method for provisioning infrastructure. We'll create a Load Balancer for Deck and other for Gate.

Navigate to AWS EC2 management console, in `Load Balancers` section, and click on `Create New Load Balancer`

![image](/images/configure_ingress_new_lb.png)

We'll be creating a new Application Load Balancer:

![image](/images/configure_ingress_create_alb.png)

Make sure to select `internal` scheme, and if you have a SSL certificate available, use `HTTPS` protocol:

![image](/images/configure_ingress_alb_1.png)

Select the VPC and subnets where EKS worker nodes live:

![image](/images/configure_ingress_alb_2.png)

If you selected `HTTPS` for the protocol, you can configure here the ACM certificate:

![image](/images/configure_ingress_alb_ssl.png)

In the next screen you can either select an existing security group or create a new one for your load balancer:

![image](/images/configure_ingress_sg.png)

Now you want to create a new target group that points to `DECK_PORT` or `GATE_PORT`, taken from the NodePort created in the previous step:

![image](/images/configure_ingress_tg.png)

Finally, you need to select all EKS worker nodes to be registered with the load balancer target, review and save the changes:

![image](/images/configure_ingress_register_targets.png)

If for some reason you get `Unhealthy` status in the target group you created, make sure that EKS worker nodes security groups allow traffic to the target ports, at least from Load Balancer's security groups.

Finally repeat the same steps for creating Gate Load balancer.

### Step 3: Update Armory configuration

Armory needs to know which url's are used to access it. After you have updated your DNS with the Load Balancers CNAME's created in the previous step, the next step is to update Armory configuration:

Update and apply the `SpinnakerService` manifest:

```yaml
apiversion: spinnaker.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      security:
        apiSecurity:
          overrideBaseUrl: https://spinnaker-gate.armory.io  # Specify your DNS name for Gate with https scheme
        uiSecurity:
          overrideBaseUrl: https://spinnaker.armory.io       # Specify your DNS name for Deck with https scheme
          ...  # rest of config omitted for brevity
```

Assuming that Armory is installed in `spinnaker` namespace:

```bash
kubectl -n spinnaker apply -f spinnakerservice.yml
```

## Exposing Armory on GKE with Ingress
### Setting up HTTP Load Balancing with Ingress

GKE has a “built-in” ingress controller and that's what we will use.

First create a file called basic-ingress.yaml and paste it the following

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: basic-ingress
spec:
  rules:
  - host: demo.armory.io
    http:
      paths:
      - backend:
          serviceName: spin-deck
          servicePort: 80  
        path: /
  - host: gate.demo.armory.io
    http:
      paths:
      - backend:
          serviceName: spin-gate
          servicePort: 80 
        path: /
```

Then apply this
`kubectl apply -f basic-ingress.yaml`

Find out the external IP address of the load balancer serving your application by running:
`kubectl get ingress basic-ingress`


Output:

```
NAME            HOSTS                                       ADDRESS         PORTS     AGE
basic-ingress   demo.armory.io, gate.demo.armory.io         203.0.113.12    80        2m
```

Note: It may take a few minutes for GKE to allocate an external IP address and set up forwarding rules until the load balancer is ready to serve your application. In the meanwhile, you may get errors such as HTTP 404 or HTTP 500 until the load balancer configuration is propagated across the globe.

You need to update your DNS records to have the demo.armory.io host point to the IP address generated.

Now tell Armory about its external endpoints:

Update and apply the `SpinnakerService` manifest:

```yaml
apiversion: spinnaker.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      security:
        apiSecurity:
          overrideBaseUrl: http://gate.demo.armory.io  # Specify your DNS name for Gate
        uiSecurity:
          overrideBaseUrl: http://demo.armory.io       # Specify your DNS name for Deck
          ...  # rest of config omitted for brevity
```

Assuming that Armory is installed in `spinnaker` namespace:

```bash
kubectl -n spinnaker apply -f spinnakerservice.yml
```

After doing that you can visit http://demo.armory.io/ to view Armory.

### Secure with SSL on GKE

To enable SSL and configure your certificates you can follow this guide:
[https://cloud.google.com/kubernetes-engine/docs/how-to/ingress-multi-ssl](https://cloud.google.com/kubernetes-engine/docs/how-to/ingress-multi-ssl)

## HTTP/HTTPS Redirects

You must enable HTTP/HTTPS redirects when your Armory deployment fits the following description:
* TLS encryption for Deck (UI) and Gate (API) for Armory
* A load balancer (service, ingress, etc.) in front of your Deck/Gate that terminates TLS and forwards communications to the Armory microservices.

To enable redirects, complete the following steps:

Update the `SpinnakerService` manifest with the following:

```yaml
apiversion: spinnaker.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      gate:
        server:
          tomcat:
            protocolHeader: X-Forwarded-Proto
            remoteIpHeader: X-Forwarded-For
            internalProxies: .*
            httpsServerPort: X-Forwarded-Port
            ...  # rest of config omitted for brevity
```

Assuming that Armory is installed in `spinnaker` namespace:

```bash
kubectl -n spinnaker apply -f spinnakerservice.yml
```

Finally, clear your cache.

For an alternative solution, see the following Knowledge Base article: [Troubleshooting http/https redirects with authentication](https://kb.armory.io/troubleshooting/https-redirects/).
