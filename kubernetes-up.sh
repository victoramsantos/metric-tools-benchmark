#!/usr/bin/env bash
#set -euox pipefail

if ! command -v kind &> /dev/null
then
    echo "kind could not be found, please install it following https://kind.sigs.k8s.io/"
    exit
fi

if ! command -v kubectl &> /dev/null
then
    echo "kubectl could not be found, please install it!"
    exit
fi


DEFAULT_CLUSTER=local-env

echo ">> Creating ${DEFAULT_CLUSTER} cluster with kind"

kind create cluster --name $DEFAULT_CLUSTER

echo ">> Setup kubectl to ${DEFAULT_CLUSTER}"
kubectl cluster-info --context kind-$DEFAULT_CLUSTER

echo ">> Everything it's ok. Apply kubernetes manifests"
kubectl apply -f ./kubernetes/.

echo ">> All manifests has been applied"
echo "For Prometheus runs:  kubectl port-forward svc/prometheus-service 9090:9090"
echo "For Grafana runs:  kubectl port-forward svc/grafana-service 3000:3000"

echo "All dashboards are already provisioned at http://localhost:3000/dashboards"
