# Define an S3 bucket to be used for storing Terraform remote state
resource "aws_s3_bucket" "remote-backend-bucket" {
    bucket = "aldan-s3-remote-state" #make sure the bucket name is unique 
}

# Enable versioning on the S3 bucket
resource "aws_s3_bucket_versioning" "backend-bucket-versioning" {
    bucket = aws_s3_bucket.remote-backend-bucket.id
    versioning_configuration {
        status = "Enabled"  # Enable versioning to keep multiple versions of an object
    }
}

# Enable server-side encryption on the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "backend-encryption" {
    bucket = aws_s3_bucket.remote-backend-bucket.id
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"  # Using AES256 encryption for objects stored in the bucket
        }
    }
}

# Create a DynamoDB table for Terraform state locking
resource "aws_dynamodb_table" "backend-statelock" {
    name             = "state-lock"
    billing_mode     = "PAY_PER_REQUEST"  # Use on-demand billing for DynamoDB
    hash_key         = "LockID"

    attribute {
        name = "LockID"  # Define the primary key for the table
        type = "S"       # Specify the type of the primary key (String)
    }
}
