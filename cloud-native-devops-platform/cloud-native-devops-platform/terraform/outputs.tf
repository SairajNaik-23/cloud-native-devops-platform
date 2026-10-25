output "ecr_repository_name" {
  description = "Created ECR repository name."
  value       = aws_ecr_repository.app.name
}

output "ecr_repository_url" {
  description = "Use this URI to tag and push container images."
  value       = aws_ecr_repository.app.repository_url
}
