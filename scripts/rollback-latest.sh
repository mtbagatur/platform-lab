#!/usr/bin/env bash
set -euo pipefail

cd ~/projects/platform-lab/infra/kubernetes

terraform apply -auto-approve -var="image=ghcr.io/mtbagatur/hello-app:latest"
kubectl rollout status deployment/hello-app -n demo --timeout=180s
kubectl get pods -n demo