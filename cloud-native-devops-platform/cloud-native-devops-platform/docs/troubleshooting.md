# Troubleshooting

- **Tests cannot import Flask:** activate the virtual environment and install `app/requirements.txt`.
- **Port 5000 already in use:** stop the other process or run Docker with another host port, e.g. `-p 8080:5000`.
- **ImagePullBackOff:** confirm image name/tag, registry permissions, and that the image is loaded/pushed to the cluster's registry.
- **CrashLoopBackOff:** inspect `kubectl -n devops-demo logs deployment/devops-demo` and `kubectl describe pod`.
- **Readiness probe fails:** verify the app listens on port 5000 and `/health` returns HTTP 200.
- **Terraform AccessDenied:** verify the AWS identity and required ECR permissions; do not solve it by granting administrator access by default.
- **Terraform state lock/conflict:** use the configured backend's locking guidance; never delete state files as a first response.
- **Jenkins cannot run Docker:** ensure the agent has access to a Docker daemon and the job is authorized to use it.
- **Datadog has no data:** verify Agent status, API key secret, site configuration, outbound connectivity, and enabled integrations.
