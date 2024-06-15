# Define the AWS provider
provider "aws" {
  region = "eu-west-2"  # Specify the AWS region to use
}

# Configure the Terraform backend to use S3 for state storage and DynamoDB for state locking
terraform {
  backend "s3" {
    bucket         = "aldan-s3-remote-state"  # Name of the S3 bucket
    dynamodb_table = "state-lock"             # Name of the DynamoDB table for state locking
    key            = "terraform/terraform.tfstate"  # Path within the bucket where the state file will be stored
    region         = "eu-west-2"              # AWS region for the S3 bucket and DynamoDB table
    encrypt        = true                     # Enable server-side encryption for the state file
  }
}