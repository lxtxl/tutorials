provider "aws" {
  region = "ap-northeast-2"
}

variable "cluster_name" {
  default = "demo"
}

variable "cluster_version" {
  default = "1.28"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31.0"
    }
  }
}
