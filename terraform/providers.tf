terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.26.0"
      }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
    }
    local = {
      source = "hashicorp/local"
      version = "2.4.0"
    }
}
}

provider "aws" {
  region     = "us-east-2"
}
provider "tls" {
}
provider "local" {
}
