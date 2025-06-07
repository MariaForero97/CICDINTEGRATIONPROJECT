provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "bucket-maria" {
  bucket = "test-bucket-maria-97"

  tags = {
    Name        = "test-bucket-maria-97"
    Environment = "Dev"
  }
}