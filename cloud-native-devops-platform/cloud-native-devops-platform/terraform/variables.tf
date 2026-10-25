variable "aws_region" {
  description = "AWS region for the ECR repository."
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Short name used for the ECR repository."
  type        = string
  default     = "cloud-native-devops-platform"
}

variable "image_tag_mutability" {
  description = "Whether ECR tags can be overwritten."
  type        = string
  default     = "IMMUTABLE"
  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "image_tag_mutability must be MUTABLE or IMMUTABLE."
  }
}
