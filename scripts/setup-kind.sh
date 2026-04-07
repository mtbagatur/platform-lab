#!/usr/bin/env bash
set -e

kind create cluster --config kind-config.yaml
kubectl cluster-info
kubectl get nodes -o wide