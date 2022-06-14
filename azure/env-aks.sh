#AKS parameters
export AZ_LOCATION=westeurope
export AZ_RESOURCE_GROUP=mendix-test
export AZ_CLUSTER_NAME=mendix-quickstart
export AZ_ACR=pablok8sreg

#Connected Mode
export CLUSTER_ID=f2d74384-fed8-4cf0-b00b-90ed1e7d3eff
export CLUSTER_SECRET=ID65Wj1qA5SAbxXG
export AKS_NS_Connected=quickstart-connected

#Standalone Mode
export AKS_NS_Standalone=quickstart-standalone

#Tekton
export PATH_TO_DOWNLOADED_FOLDERS=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P) #Current working directory
export URL_TO_YOUR_REPO_WITHOUT_TAG=pablok8sreg.azurecr.io
#export YOUR_NAMESPACE=quickstart-aks #Use StandaloneNS
#export YOUR_NAMESPACE_WITH_PIPELINES=quickstart-aks
export SOME_UNIQUE_NAME=aks-tkn