output "repo_url" {
  value = aws_codecommit_repository.flaskapp.clone_url_http
}
