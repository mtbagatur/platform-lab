#!/usr/bin/env bash
set -e

docker build -t hello-app:dev ./app
kind load docker-image hello-app:dev --name platform-lab