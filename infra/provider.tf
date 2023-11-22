provider "aws" {
  region = "us-west-2" //I choose Oregon for cust proposes!! 
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}