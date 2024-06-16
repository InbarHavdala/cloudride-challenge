variable "aws_region" {
  description = "The AWS region to deploy in"
  default     = "eu-west-1"
}

variable "ecr_repository_name" {
  description = "The name of the ECR repository"
  default     = "hello-world-repo"
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  default     = "ecs-cluster"
}

variable "app_name" {
  description = "The name of the application"
  default     = "hello_world"
}
