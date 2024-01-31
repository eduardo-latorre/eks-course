provider "aws" { # To use aws credentials
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

terraform { # To set a constraint
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}