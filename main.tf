terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "domain_name" {
  description = "The name of the domain for our website"
  default = "explorekokshetau"
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "PublicReadGetObject"
    effect = "Allow"
    actions = [ "s3:GetObject" ]
    principals {
      type = "*"
      identifiers = [ "*" ]
    }
    resources = [ "arn:aws:s3:::${var.domain_name}/*" ]
  }
}

resource "aws_s3_bucket" "mysite" {
  bucket = var.domain_name
}

resource "aws_s3_bucket_website_configuration" "mysite" {
  bucket = aws_s3_bucket.mysite.id
  index_document {
    suffix = "index.htm"
  }
  error_document {
    key = "error.htm"
  }
}

resource "aws_s3_bucket_acl" "mysite_acl" {
  bucket = aws_s3_bucket.mysite.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "mysite_policy" {
  bucket = aws_s3_bucket.mysite.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}

output "website_bucket_url" {
  value = aws_s3_bucket_website_configuration.mysite.website_endpoint
}
