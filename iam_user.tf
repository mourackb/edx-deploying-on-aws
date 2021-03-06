resource "aws_iam_user" "EdxUser" {
  name = "EdxUser1"
  path = "/"
}

resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = aws_iam_user.EdxUser.name
  policy_arn = aws_iam_policy.edxDeployingPolicy.arn
}
