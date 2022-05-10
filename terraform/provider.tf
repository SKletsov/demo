provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.69.0"
    }
  }
  backend "s3" {
    bucket = "sergey-lab-bucket"
    key    = "lab/terraform.tfstate"
    region = "us-east-1"
  }
  required_version = ">= 1.0.1"
}