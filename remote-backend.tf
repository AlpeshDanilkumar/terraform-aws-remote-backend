#s3 config 
resource "aws_s3_bucket" "remote-backend-bucket" {
    bucket = "aldan-s3-remote-state"
    }

resource "aws_s3_bucket_versioning" "backend-bucket-versioning" {
    bucket = aws_s3_bucket.remote-backend-bucket.id
    versioning_configuration {
      status = "Enabled"
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backend-encryption" {
    bucket = aws_s3_bucket.remote-backend-bucket.id
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  
}

#DYNAMODB

resource "aws_dynamodb_table" "backend-statelock" {
  name             = "state-lock"
  billing_mode     = "PAY_PER_REQUEST"
  hash_key         = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}