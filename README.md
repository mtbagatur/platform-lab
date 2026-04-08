# Platform Lab

A hands-on local DevOps lab built on Ubuntu to practice a real-world containerized application workflow end-to-end.

## What this project demonstrates

- VS Code based development workflow
- SSH key authentication with GitHub
- Git repository management with commit/push flow
- Docker image build process
- Image publishing to GitHub Container Registry (GHCR)
- Local Kubernetes cluster with kind
- Kubernetes operations with kubectl
- Infrastructure management with Terraform
- Configuration management with ConfigMap and Secret
- Deployment troubleshooting with rollout, describe, and image debugging

## Architecture

Flow:

1. Application code is developed locally in VS Code
2. Docker image is built locally
3. Image is tagged with the current Git SHA
4. Image is pushed to GHCR
5. Terraform deploys Kubernetes resources
6. Kubernetes pulls the exact image tag
7. kubectl is used for rollout tracking and debugging

## Project Structure

```text
platform-lab/
├── app/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
├── infra/
│   └── kubernetes/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── scripts/
│   ├── deploy-ghcr.sh
│   ├── setup-kind.sh
│   ├── build-and-load.sh
│   └── test-app.sh
├── .vscode/
├── kind-config.yaml
├── Makefile
└── README.md
```

## Technologies Used

- Ubuntu
- VS Code
- Git + GitHub
- SSH
- Docker
- GHCR
- kind
- Kubernetes
- kubectl
- Terraform
- Flask

## Endpoints

- `/` → basic application response
- `/health` → liveness/readiness endpoint
- `/info` → runtime/environment/config visibility

## Prerequisites

Installed locally:

- git
- docker
- kubectl
- terraform
- kind
- python3
- VS Code
- GitHub account
- GHCR login

## GHCR Login

```bash
echo 'YOUR_GITHUB_TOKEN' | docker login ghcr.io -u YOUR_GITHUB_USERNAME --password-stdin
```

## Local Kubernetes Cluster Setup

```bash
kind create cluster --config kind-config.yaml
kubectl get nodes
```

## Build, Push, and Deploy

```bash
./scripts/deploy-ghcr.sh
```

This script:

- builds the Docker image
- tags it with the current Git SHA
- pushes it to GHCR
- deploys it with Terraform
- waits for rollout completion

## Verify Deployment

```bash
kubectl get pods -n demo
kubectl get deploy hello-app -n demo -o=jsonpath='{.spec.template.spec.containers[0].image}'; echo
```

## Access the App

```bash
kubectl port-forward -n demo svc/hello-app-svc 8080:80
```

Then open:

- http://localhost:8080/
- http://localhost:8080/health
- http://localhost:8080/info

## What I Practiced

- building and pushing container images
- using exact Git SHA based image versioning
- deploying Kubernetes resources declaratively with Terraform
- consuming ConfigMap and Secret as environment variables
- troubleshooting ImagePullBackOff and rollout failures
- distinguishing between `latest` tag issues and exact version deployment
- understanding cluster-side image pull behavior

## Key Lessons Learned

- `latest` is convenient but risky for deterministic deployments
- exact image tags are much safer than mutable tags
- ConfigMap and Secret wiring can work correctly even if the running app image is stale
- rollout failures often come from image/tag/registry mismatches rather than Kubernetes itself
- infrastructure and application delivery should be traceable through versioned artifacts

## Next Steps

Planned next improvements:

- Helm chart packaging
- Ingress controller and host-based routing
- remote server deployment
- CI/CD refinement
- cloud deployment path with Azure or another provider
