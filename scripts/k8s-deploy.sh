#!/bin/bash

set -e

echo "Applying Kubernetes manifests..."

kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/mongodb/
kubectl apply -f kubernetes/backend/
kubectl apply -f kubernetes/ingress.yaml

echo "Deployment complete."

kubectl get all -n muchtodo