#!/bin/bash
set -e

echo "Applying Kubernetes manifests..."
kubectl apply -f deployment.yml
kubectl apply -f service.yml

echo "Deployment completed on EKS."
