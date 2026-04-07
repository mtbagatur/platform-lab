#!/usr/bin/env bash
set -e

kubectl get ns
kubectl get pods -n demo
kubectl get svc -n demo
kubectl port-forward -n demo svc/hello-app-svc 8080:80