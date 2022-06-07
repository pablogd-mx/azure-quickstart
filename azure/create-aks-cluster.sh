#!/usr/bin/env bash
set -x

echo " Please login to Azure first:"
az login

## Check for required commands
command -v az > /dev/null || { echo "'az' command not not found" 1>&2; exit 1; }
command -v jq > /dev/null || { echo "'jq' command not not found" 1>&2; exit 1; }

## Default variables
 
AZ_VM_SIZE=${AZ_VM_SIZE:-Standard_B2ms}

## Check for required variables
[[ -z "${AZ_RESOURCE_GROUP}" ]] && { echo 'AZ_RESOURCE_GROUP not specified. Aborting' 1>&2 ; exit 1; }
[[ -z "${AZ_CLUSTER_NAME}" ]] && { echo 'AZ_CLUSTER_NAME not specified. Aborting' 1>&2 ; exit 1; }

## Create the resource group (idempotently)
if ! az group list | jq '.[].name' -r | grep -q ${AZ_RESOURCE_GROUP}; then
  [[ -z "${AZ_LOCATION}" ]] && { echo 'AZ_LOCATION not specified. Aborting' 1>&2 ; exit 1; }
  az group create --name=${AZ_RESOURCE_GROUP} --location=${AZ_LOCATION}
else
  echo "'${AZ_RESOURCE_GROUP}' resource group is already created, skipping."
fi

## create aks cluster if resource group was created
if az group list | jq '.[].name' -r | grep -q ${AZ_RESOURCE_GROUP}; then
  ## check if AKS cluster was already created
  if ! az aks list | jq '.[].name' -r | grep -q ${AZ_CLUSTER_NAME}; then
    echo "Creating '${AZ_CLUSTER_NAME}' Kubernetes cluster"
    az aks create \
        --resource-group ${AZ_RESOURCE_GROUP} \
        --name ${AZ_CLUSTER_NAME} \
        --generate-ssh-keys \
        --vm-set-type VirtualMachineScaleSets \
        --node-vm-size ${AZ_VM_SIZE} \
        --load-balancer-sku standard \
        --enable-managed-identity \
        --node-count 1 \
        --zones 1 
  else
    echo "'${AZ_CLUSTER_NAME}' Kubernetes cluster is already created, skipping."
  fi

  ## create KUBECONFIG so that cluster can be accessed using existing login credentials
  if az aks list | jq '.[].name' -r | grep -q ${AZ_CLUSTER_NAME}; then
    ## Azure ignores KUBECONFIG, but we can specify with --file flag
    az aks get-credentials \
      --resource-group ${AZ_RESOURCE_GROUP} \
      --name ${AZ_CLUSTER_NAME} \
   #Attach ACR registry to the AKS cluster so it can be accessed by Mendix later
   az aks update -n $AZ_CLUSTER_NAME -g $AZ_RESOURCE_GROUP --attach-acr $AZ_ACR
  fi
fi