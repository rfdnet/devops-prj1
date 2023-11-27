provider "aws" {
  region = "us-west-2" //I choose Oregon for cust proposes!! 

  default_tags {
   tags = {
     proj = "Demo"
     manageBy = "beatiful terraform :-)"
     Owner = "eu mesmo"
   }
   
  }

}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {

  }
}