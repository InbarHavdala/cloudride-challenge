provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "bucket" {
  bucket = "inbar-terraform-state-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_ecr_repository" "hello_world_repo" {
  name = var.ecr_repository_name
}
