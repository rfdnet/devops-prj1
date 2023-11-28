provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      Project = "demo"
      ManagedBy = "terraform"
      Owner = "Reinaldo Dias"

    }
  }
}

# //Local Backend
# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.0"
#     }
#   }
# }

//Remote Backend
terraform {
  backend "s3" {


  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


// s3 bucket for tf remote state
resource "aws_s3_bucket" "terraform_state" {
  bucket        = "my-devops-project-01-tf-state-2023"
  force_destroy = true
  tags = {
    Name        = "TF state bucket"
    Environment = "dev"
  }

  # lifecycle {
  #   prevent_destroy = true
  # }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"

      }
    }
  }

}
//DynameDB table for terraform state
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

}