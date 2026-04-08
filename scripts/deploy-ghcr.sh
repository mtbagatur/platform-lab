#!/usr/bin/env bash
set -euo pipefail

APP_NAME="hello-app"
GITHUB_USER="mtbagatur"
IMAGE_BASE="ghcr.io/${GITHUB_USER}/${APP_NAME}"

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_DIR="${PROJECT_ROOT}/app"
TF_DIR="${PROJECT_ROOT}/infra/kubernetes"

cd "${PROJECT_ROOT}"

SHA="$(git rev-parse --short HEAD)"
IMAGE="${IMAGE_BASE}:${SHA}"

echo "==> Project root: ${PROJECT_ROOT}"
echo "==> Git SHA: ${SHA}"
echo "==> Image: ${IMAGE}"

echo "==> Building Docker image"
docker build -t "${IMAGE}" "${APP_DIR}"

echo "==> Pushing image to GHCR"
docker push "${IMAGE}"

echo "==> Applying Terraform"
cd "${TF_DIR}"
terraform apply -auto-approve -var="image=${IMAGE}"

echo "==> Forcing rollout restart"
kubectl rollout restart deployment/hello-app -n demo

echo "==> Waiting for rollout"
kubectl rollout status deployment/hello-app -n demo --timeout=180s

echo "==> Current pods"
kubectl get pods -n demo -o wide

echo "==> Active image"
kubectl get deploy hello-app -n demo -o=jsonpath='{.spec.template.spec.containers[0].image}'
echo