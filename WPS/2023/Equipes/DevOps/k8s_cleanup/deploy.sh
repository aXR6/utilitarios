#!/bin/bash

if ! command -v kubectl &> /dev/null; then
    echo 'kubectl is not installed'
    exit 1
fi

kubectl -n kube-system apply -f rbac.yml && 
kubectl -n kube-system apply -f docker-clean.yml && 
kubectl -n kube-system apply -f k8s-clean.yml && 
kubectl -n kube-system apply -f etcd-empty-dir-cleanup.yml