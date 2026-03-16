terraform {
  backend "s3" {
    bucket         = "amey-terraform-state-bucket"
    key            = "aws-networking/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}
