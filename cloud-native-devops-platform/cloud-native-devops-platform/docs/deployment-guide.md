# Deployment guide

## AWS ECR

1. Install AWS CLI and Terraform.
2. Authenticate with an AWS profile or role with only the required ECR permissions.
3. Run Terraform from `terraform/` after reviewing `terraform plan`.
4. Read `terraform output ecr_repository_url`.
5. Authenticate Docker to the registry using `aws ecr get-login-password`, tag the image with the returned registry URI, and push it.

Example pattern (replace placeholders with your real output):

```bash
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com
docker tag cloud-native-devops-platform:local <ECR_URI>:v1
docker push <ECR_URI>:v1
```

## Jenkins requirements

The Jenkins agent needs Git, Python 3.11, Docker CLI/daemon access, AWS CLI, and kubectl if deployment is enabled. Configure AWS access through an instance/task role or Jenkins credential binding. Provide `ECR_REGISTRY` (registry host, not repository URI), `AWS_DEFAULT_REGION`, and optionally `DEPLOY_TO_K8S=true` only after the target cluster context and RBAC are configured.

The pipeline is a template. Verify that the Jenkins agent's AWS identity can push to the repository and that the Kubernetes context points to the intended non-production cluster. Do not enable deploy stage on a production cluster without a proper review and approval process.

## Terraform scope

The included Terraform does not create a Kubernetes cluster. Configure an existing local or managed cluster separately. If adding EKS, include networking, IAM, node capacity, access entries, and teardown documentation.
