resource "aws_s3_bucket" "my-bucket" {
  bucket = "tech-blog-bootcamp-tf"

  tags = {
    Name        = "My tech blog with terraform"
    Environment = "Development"
  }

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my-bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "index" {
  bucket       = aws_s3_bucket.my-bucket.id
  key          = "index.html"
  source       = "../public/index.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_public_access_block" "allow_public" {
  bucket = aws_s3_bucket.my-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
