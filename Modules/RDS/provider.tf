terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0" # Adjust based on your needs
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0" # Adjust as needed
    }
  }

  required_version = ">= 1.3.0"
}
