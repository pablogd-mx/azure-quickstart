#!/bin/bash
# Tekton
NAMESPACE=tekton-pipelines
echo " Creating Tekton Pipeline folder"
cd $PATH_TO_DOWNLOADED_FOLDERS


echo "Creating a new Namespace: tekton-pipelines"
kubectl create ns $NAMESPACE
sleep 2

echo "Installing Tekton"
echo "kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/previous/v0.26.0/release.notags.yaml"
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/previous/v0.26.0/release.notags.yaml
sleep 5
echo " Tekton Triggers installation - tekton-triggers.yaml and interceptors.yaml"
# Tekton triggers
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/previous/v0.26.0/release.yaml
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/previous/v0.15.0/release.yaml
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/previous/v0.15.0/interceptors.yaml


sleep 10

echo " Installing Tekton Dashboard"
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml

echo " Installing mx-tekton-pipeline via HELM charts "
cd $PATH_TO_DOWNLOADED_FOLDERS && cd helm/charts
helm install -n $YOUR_NAMESPACE mx-tekton-pipeline ./pipeline/ \
  -f ./pipeline/values.yaml \
  --set images.imagePushURL=$URL_TO_YOUR_REPO_WITHOUT_TAG
sleep 10
echo " Installing Generic Triggers"

cd $PATH_TO_DOWNLOADED_FOLDERS && cd helm/charts
helm template mx-tekton-pipeline-trigger ./triggers -f triggers/values.yaml \
    --set name=$SOME_UNIQUE_NAME \
    --set pipelineName=build-pipeline \
    --set triggerType=generic | kubectl apply -f - -n $YOUR_NAMESPACE

sleep 10
echo "Applying Port Forward to port 9097"
kubectl --namespace $NAMESPACE port-forward svc/tekton-dashboard 9097:9097 &


echo "Forwarding Tekton Listener to port 8080"
kubectl --namespace $NAMESPACE port-forward svc/el-mx-pipeline-listener-$YOUR_NAMESPACE 8080:8080