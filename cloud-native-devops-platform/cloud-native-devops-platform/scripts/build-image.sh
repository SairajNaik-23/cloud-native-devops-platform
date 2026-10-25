#!/usr/bin/env bash
set -euo pipefail
IMAGE="${1:-cloud-native-devops-platform:local}"
docker build -f docker/Dockerfile -t "$IMAGE" .
echo "Built image: $IMAGE"
