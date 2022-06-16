

# Azure Mendix quickstart
Azure Mendix Private Cloud Quickstart

    Scripted install of AKS Cluster in Azure.
    Install Nginx Ingress controllers
    Configure Namespace for Mendix either for Connected or Standalone mode
    Deploys a demo Mendix application
    If Standalone mode is selected, it also installs Tekton Pipelines and Dashboard
    Installs Grafana, Prometheus and Loki.


## Prerequisites:

### For Azure AKS
    - az cli 
    - A valid Azure subscription
    - kubectl
    - helm

##### Note: This has been tested on an Apple Macintosh only

# Configurations

## AKS
### env-aks.sh

  `- export AZ_LOCATION=westeurope
  - export AZ_RESOURCE_GROUP=mendix-test
  - export AZ_CLUSTER_NAME=mendix-quickstart
  - export AZ_ACR=TODO`

#Connected Mode
 `- export CLUSTER_ID=TODO
 - export CLUSTER_SECRET=TODO
 - export AKS_NAMESPACE= TODO`

#Tekton
 `- export PATH_TO_HELM= TODO # usually the current working directory
 - export URL_TO_YOUR_REPO_WITHOUT_TAG=TODO
 - export YOUR_NAMESPACE=TODO # where Mendix Operator is installed
 - export SOME_UNIQUE_NAME=TODO`


## Ensure that you can run mxpc-cli
Your Mac's security settings may prevent the downloaded mxpc-cli from executing.

. ./mxpc-cli -help

## Create Cluster, Configure and Deploy Mendix application

Default is connected mode

    . ./do-all.sh connected
          or
    . ./do-all.sh standalone

## Mendix application
Mendix application will be available at apurl seen in MendixCR or at Ingress ( kubectl get ing -A)

## Prometheus
Available at the external ip address of the prometheus svc port 9090

kubectl get svc -n grafana | grep -i Loadbalancer

Example:
http://ab5b2c0d274690ae9d506d21ed876-1145176934.us-east-2.elb.amazonaws.com:9090/


## Tekton
  `- Tekton dashboard will be exposed at port 9097
  - Tekton listener will be forwarded to port 8080 ( only Generic HTTP listener is installed in the procedure).`

## Deleting the cluster

`./del-aks-cluster.sh will delete the cluster`

## References
Install the Mendix components on the cluster using the instructions here - https://docs.mendix.com/developerportal/deploy/private-cloud-cli-non-interactive