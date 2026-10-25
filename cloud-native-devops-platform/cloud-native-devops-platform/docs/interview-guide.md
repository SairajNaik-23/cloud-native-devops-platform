# Interview guide

## 60-second introduction

“This is a DevOps portfolio project built around a small Python Flask service. The repository demonstrates automated tests, Docker packaging, Kubernetes deployment manifests, Terraform-managed Amazon ECR, a Jenkins pipeline template, GitHub Actions validation, and a Datadog monitoring plan. I designed it to show how source control, build, image publishing, deployment, and observability fit together. The current Terraform example provisions ECR only; Kubernetes and Datadog need to be configured separately, so I distinguish repository implementation from anything I have actually deployed.”

Use this wording only while it accurately describes the repository's current state. Update it after you complete and verify further steps.

## 2–3 minute walkthrough

Start with the app and its `/health` endpoint. Tests verify the HTTP response. Docker packages the app and runs it as a non-root user. Kubernetes defines a Deployment with resource requests/limits and health probes, plus a ClusterIP Service. Terraform creates an encrypted ECR repository with image scanning and a lifecycle policy. GitHub Actions validates the tests and Terraform configuration on pushes and pull requests. Jenkins provides a separate delivery pipeline that tests and builds an image, then conditionally publishes it on `main` when registry settings are configured. Deployment is opt-in and needs an existing cluster context. Datadog instructions explain how to add Agent-based monitoring after a cluster is available.

## Technology choices

- **AWS:** cloud registry and potential managed runtime.
- **Terraform:** repeatable, reviewable infrastructure definitions.
- **Jenkins:** pipeline orchestration and delivery stages.
- **Docker:** consistent application packaging.
- **Kubernetes:** declarative workload management and health checks.
- **Datadog:** centralized metrics, logs, and alerts when configured.
- **GitHub:** source control, review, and automated validation.
- **Linux:** common environment for agents, containers, and shell tooling.

## Flow to explain

Commit → GitHub Actions validation → Jenkins checkout/tests → Docker build → optional ECR push → optional Kubernetes apply/rollout check → Datadog Agent/integrations collect telemetry.

## Technical questions and answers

1. **What is CI vs CD?** CI validates changes frequently; CD automates delivery or deployment after required checks.
2. **Why Terraform?** It describes infrastructure declaratively and provides plan/apply review before changes.
3. **What is Terraform state?** It maps configuration to managed resources. Protect it and use a secure backend for teams.
4. **Why ECR?** It is a managed private registry integrated with AWS IAM.
5. **What is an immutable image tag?** A tag that cannot be overwritten in the repository; unique build tags aid traceability.
6. **Why Docker?** It packages the application and dependencies into a repeatable runtime image.
7. **Why run as non-root?** It reduces privileges if the application is compromised.
8. **What is a Kubernetes Deployment?** A controller that maintains the desired number of pod replicas and manages rollout.
9. **What is a Service?** A stable network endpoint for selected pods.
10. **Readiness vs liveness probe?** Readiness controls whether a pod receives traffic; liveness can trigger a restart if the process is unhealthy.
11. **What are requests and limits?** Requests guide scheduling; limits cap resource use.
12. **What is a ConfigMap?** A mechanism for non-sensitive configuration.
13. **Where should secrets live?** In a secret manager or securely managed Kubernetes/Jenkins credentials, never in Git.
14. **What does Jenkins do here?** It checks out, tests, builds, and can publish/deploy when configured.
15. **Why also use GitHub Actions?** It gives quick repository checks on pull requests; Jenkins demonstrates a separate delivery workflow.
16. **How is AWS auth handled?** Prefer roles or short-lived credentials; scope permissions to required actions.
17. **What is ECR image scanning?** A registry feature that checks images for known vulnerabilities; findings still require review and remediation.
18. **What does Datadog Agent do?** Collects configured telemetry from hosts, containers, and integrations.
19. **What is observability?** Using metrics, logs, and traces/events to understand system behavior.
20. **What is ImagePullBackOff?** Kubernetes cannot pull the specified image; check image URI, tag, registry auth, and network.
21. **How would you debug CrashLoopBackOff?** Inspect pod events, container logs, command/configuration, probes, and resource limits.
22. **What if Jenkins tests fail?** Stop before image publishing/deployment, inspect test output, and fix the cause.
23. **What if Terraform reports AccessDenied?** Identify the active principal and missing action/resource, then grant the minimum required permission.
24. **What if Terraform state is locked?** Identify the lock owner and operation first; use backend-supported recovery only after confirming no active operation.
25. **What if Datadog has no data?** Check Agent status, API key/site, network egress, integrations, and tags.
26. **Why use a health endpoint?** It gives probes and operators a simple signal that the service responds.
27. **Why use a lifecycle policy in ECR?** To limit old image accumulation and help control storage.
28. **Why not deploy automatically to production?** Production requires approvals, access controls, rollout strategy, and rollback planning.
29. **What is the current infrastructure limitation?** Terraform here creates ECR only; it does not provision VPC or EKS.
30. **How would you improve the project?** Add an IaC-managed network and EKS option, policy/security scanning, artifact provenance, secrets integration, rollback strategy, and validated alerts.

## Scenario practice

- **Pipeline fails at tests:** reproduce locally, inspect traceback, fix code/test/dependency issue, and rerun before publishing.
- **Pod is unhealthy:** inspect `kubectl describe pod`, logs, probe path/port, and resource events.
- **Image cannot be pulled:** verify the full registry URI/tag and workload pull permissions.
- **Terraform plan unexpectedly replaces a resource:** stop; inspect the plan, state, provider/version changes, and resource lifecycle before applying.
- **No metrics arrive:** inspect Agent status and configuration, verify connectivity and key, then validate the integration.

These are hypothetical scenarios, not claims that you have personally experienced them.
