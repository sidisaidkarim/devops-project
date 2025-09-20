terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3" # Paris, ou us-east-1 si tu préfères
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "mon-bucket-terraform-demo-123456"
}
