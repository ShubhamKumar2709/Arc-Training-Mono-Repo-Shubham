terraform {
  required_version = ">= 1.3.0" # Adjust to your Terraform version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Adjust the version if needed
    }
  }
}
