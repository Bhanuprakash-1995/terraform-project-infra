terraform {
  backend "s3" {
    bucket         = "roboshop-01"
    key            = "catalogue-02"
    region         = "us-east-1"
    dynamodb_table = "roboshopapp-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}
