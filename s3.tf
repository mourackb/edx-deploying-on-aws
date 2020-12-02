resource "aws_s3_bucket" "b" {
  bucket = "study-aws-chandeliasdsad1"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
