#!/usr/bin/env bash
set -euo pipefail
NAMESPACE="${NAMESPACE:-devops-demo}"
case "${1:-}" in
  status) kubectl -n "$NAMESPACE" get deployment,pods,service ;;
  logs) kubectl -n "$NAMESPACE" logs deployment/devops-demo ;;
  rollout) kubectl -n "$NAMESPACE" rollout status deployment/devops-demo ;;
  delete) kubectl delete -f k8s/ ;;
  *) echo "Usage: $0 {status|logs|rollout|delete}" >&2; exit 2 ;;
esac
