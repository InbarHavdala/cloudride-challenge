terraform {
  backend "s3" {
    bucket = "inbar-terraform-state-bucket"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}
