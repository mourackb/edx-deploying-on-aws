resource "aws_codecommit_repository" "flaskapp" {
  repository_name = "edX-Deploying"
  description     = "edX-Deploying repository as  part of EdX training"
}
