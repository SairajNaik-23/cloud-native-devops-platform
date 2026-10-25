# Architecture

## Request path

A client sends an HTTP request to the Flask service. The `/health` endpoint returns a small JSON health response. In Kubernetes, a ClusterIP Service forwards port 80 to the container's port 5000.

## Delivery path

1. Code is committed to GitHub.
2. GitHub Actions runs tests and Terraform validation.
3. Jenkins checks out the repository, runs tests, and builds a container.
4. On `main`, Jenkins can publish a versioned image if ECR settings and permissions are configured.
5. An explicitly enabled deployment stage applies the Kubernetes resources and waits for rollout status.
6. Datadog Agent/integrations can collect Kubernetes and container telemetry after separately configured.

## Scope boundary

Terraform currently provisions an ECR repository and lifecycle policy only. VPC and EKS are not provisioned by these files. Use a local cluster first or extend Terraform after reviewing AWS costs and required IAM/network configuration.
