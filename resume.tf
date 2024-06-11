provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "sample" {
  bucket = "aadhi-resume-bucket"

  tags = {
    Name        = "Aadhi Bucket"
  }
}


resource "aws_s3_bucket_public_access_block" "example" {
    bucket = aws_s3_bucket.sample.id

    block_public_acls  = false
    ignore_public_acls = false
}

resource "aws_s3_bucket_website_configuration" "example1" {
  bucket = aws_s3_bucket.sample.id

  index_document {
    suffix = "aadhi-resume.html"
  }

  error_document {
    key = "ebucketrror.html"
  } 
}


resource "aws_s3_bucket_policy" "allow_access_S3bucket" {
  bucket = aws_s3_bucket.sample.id
  policy = jsonencode(
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.sample.arn}/*"
        }
    ]
  }
  )
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.sample.id
  key    = "aadhi-resume.html"
  source = "aadhi-resume.html"
  content_type = "text/html"
}

