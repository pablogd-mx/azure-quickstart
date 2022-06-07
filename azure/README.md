

# Azure Mendix quickstart
Azure Mendix Private Cloud Quickstart

    Scripted install of AKS Cluster in Azure.
    Install nginx ingress controllers
    Configure Namespace for mendix either for Connected or Standalone mode
    Deploys a demo Mendix application
    If Standalone mode is selected, installs Tekton Pipelines and Dashboard
    Installs Grafana, Prometheus and Loki.

## Sequence Diagram

![Sequence Diagram](/images/sequence.png)

## Prerequisites:
    
### For Azure AKS
    - az cli 
    - A valid Azure subscription
    - kubectl
    - helm
    - mxpc-cli - It is packaged here. Change version and OS from env-aks file.

## Note: This has been tested on an Apple Macintosh only

# Configurations

## AKS
### env-aks.sh

 - export AZ_LOCATION=westeurope
 - export AZ_RESOURCE_GROUP=mendix-test
 - export AZ_CLUSTER_NAME=mendix-quickstart
 - export AZ_ACR=TODO

#Connected Mode
export CLUSTER_ID=TODO
export CLUSTER_SECRET=TODO
export AKS_NAMESPACE=quickstart-aks

#Tekton
export PATH_TO_DOWNLOADED_FOLDERS=~/Documents/Mendix/quickstart/azure-mendix-quickstart/tekton
export URL_TO_YOUR_REPO_WITHOUT_TAG=pablok8sreg.azurecr.io
export YOUR_NAMESPACE=quickstart-aks
export YOUR_NAMESPACE_WITH_PIPELINES=quickstart-aks
export SOME_UNIQUE_NAME=aks-tkn
    
# Azure AKS
## env-aks.sh 
export AZ_LOCATION="" 
export AZ_RESOURCE_GROUP="" 
export AZ_CLUSTER_NAME=""


## Ensure that you can run mxpc-cli
   Your Mac's security sesttings may prevent the downloaded mxpc-cli from executing.

   . ./mxpc-cli -help

## Create Cluster, Configure and Deploy Mendix application

Default is connected mode

    . ./do-all.sh connected
          or
    . ./do-all.sh standalone


## Validation

    Added validate.sh that is called at the end of do-all.sh
    It will show if the result was Successful or not.

    validate.sh - Success: Number of running pods is  16

    Result:
    validate.sh - Success: Number of running demo application pods is  1


## Mendix application
  Mendix application will be available at apurl seen in the generated demo.yaml

  Example:
  appURL: demo.18.118.31.87.nip.io        

## Prometheus
   Available at the external ip address of the prometheus svc port 9090

   kubectl get svc -n grafana | grep -i Loadbalancer

   Example:
   http://ab5b2c0d274690ae9d506d21ed876-1145176934.us-east-2.elb.amazonaws.com:9090/


## Generated files

  generate-yamls.sh creates
      configure.yaml
      configure-standalone.yaml
      demo.yaml


## Deleting the cluster

   del-cluster.sh will delete the cluster

## Screenshots

   https://github.com/ssahadevan-mendix/aws-mendix-quickstart/wiki


## References
Install the Mendix components on the cluster using the instructions here - https://docs.mendix.com/developerportal/deploy/private-cloud-cli-non-interactive
