#AKS parameters
export AZ_LOCATION=TODO
export AZ_RESOURCE_GROUP=TODO
export AZ_CLUSTER_NAME=TODO
export AZ_ACR=TODO #name of the registry in Azure that Mendix will use to store its images

#Connected Mode
export CLUSTER_ID= TODO
export CLUSTER_SECRET= TODO
export AKS_NS_Connected=TODO #Namespace to create for Connected Mode installation

#Standalone Mode
export AKS_NS_Standalone=TODO

#Tekton
export PATH_TO_HELM=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P) #Current working directory
export URL_TO_YOUR_REPO_WITHOUT_TAG=TODO #ACR registry to store tekton images.
export SOME_UNIQUE_NAME= TODO # Name for tekton pods
export TEKTON_NAMESPACE= TODO # Tekton pipeline namespace

#MXPC
export MXPC_VERSION=TODO #Version of MXPC to download
export MXPC_OS=TODO # version of OS from where the mxpc-cli will be lauched. For example macos-amd64

