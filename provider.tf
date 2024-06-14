provider "aws" {
  region     = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "aldan-s3-remote-state"
    dynamodb_table = "state-lock"
    key = "terraform/terraform.tfstate"
    region = "eu-west-2"
    encrypt = true
    
  }
}