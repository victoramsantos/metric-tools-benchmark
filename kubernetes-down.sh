#!/usr/bin/env bash
#set -euox pipefail

if ! command -v kind &> /dev/null
then
    echo "kind could not be found, please install it following https://kind.sigs.k8s.io/"
    exit
fi

DEFAULT_CLUSTER=local-env

echo ">> Uninstalling ${DEFAULT_CLUSTER} cluster"
kind delete cluster --name $DEFAULT_CLUSTER