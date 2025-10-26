terraform {
  backend "s3" {
    bucket         = "terraform-backend-anand-123"   # your S3 bucket name
    key            = "dev/terraform.tfstate"     # path within the bucket
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"           # DynamoDB table name
    encrypt        = true
  }
}
