resource "aws_s3_bucket" "b" {
  bucket = "study-aws-chandeliasdsad"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
