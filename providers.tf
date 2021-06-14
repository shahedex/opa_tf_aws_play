provider "aws" {
  region = var.region
}

# terraform {
#   backend "s3" {
#       bucket = "somebucketxxxxxx"
#       key = "terraform.tfstate"
#       region = "ap-southeast-1"
#       dynamodb_table = "terraform_aws"
#   }
# }
