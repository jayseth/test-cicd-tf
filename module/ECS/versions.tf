terraform {
  required_version = ">= 0.12.6"

  required_providers {
    aws = ">= 2.68"
  }
}

provider "aws" {
  region = "us-east-1"
}