# Datadog monitoring setup

This document describes a setup path; it does not mean Datadog has been configured or telemetry is currently flowing.

## Suggested signals

- **Availability:** Kubernetes readiness/liveness probe status and application `/health` endpoint.
- **Workload health:** pod restarts, desired vs available replicas, CPU and memory usage.
- **Application logs:** stdout/stderr from the container, with service/environment tags.
- **Alerts:** sustained pod restarts, unavailable replicas, or a failed health check.

## Setup outline

1. Create or use a Datadog account and select the correct site for that account.
2. Store the Datadog API key in a Kubernetes Secret or an approved secret manager; never commit it.
3. Install the Datadog Agent using the current official Kubernetes instructions and Helm chart for your environment.
4. Configure Kubernetes/container collection and verify that the Agent can reach Datadog.
5. Add service/environment tags and confirm logs are collected before creating alerts.
6. Create monitors with thresholds appropriate to the actual workload. Avoid inventing alert thresholds as measured facts.

Datadog features and pricing vary by plan and configuration. Check current vendor documentation and billing before enabling log ingestion or paid features. For a local kind cluster, use this as a learning guide; a hosted Datadog account and outbound connectivity are still needed.
