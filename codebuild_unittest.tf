# resource "aws_s3_bucket" "cd-edx-artifacts" {
#   bucket = "cd-edx-artifacts1"
#   acl    = "private"
# }
#
# resource "aws_iam_role" "code-build-role" {
#   name = "code-build-role"
#
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "codebuild.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF
# }
#
# resource "aws_iam_role_policy" "code-build-role-policy" {
#   role = aws_iam_role.code-build-role.name
#
#   policy = <<POLICY
# {
# 	"Version": "2012-10-17",
# 	"Statement": [{
# 			"Effect": "Allow",
# 			"Resource": [
# 				"*"
# 			],
# 			"Action": [
# 				"logs:CreateLogGroup",
# 				"logs:CreateLogStream",
# 				"logs:PutLogEvents"
# 			]
# 		},
# 		{
# 			"Effect": "Allow",
# 			"Action": [
# 				"ec2:CreateNetworkInterface",
# 				"ec2:DescribeDhcpOptions",
# 				"ec2:DescribeNetworkInterfaces",
# 				"ec2:DeleteNetworkInterface",
# 				"ec2:DescribeSubnets",
# 				"ec2:DescribeSecurityGroups",
# 				"ec2:DescribeVpcs"
# 			],
# 			"Resource": "*"
# 		},
# 		{
# 			"Effect": "Allow",
# 			"Action": [
# 				"ec2:CreateNetworkInterfacePermission"
# 			],
# 			"Resource": [
# 				"arn:aws:ec2:us-east-1:506189848464:network-interface/*"
# 			],
# 			"Condition": {
# 				"StringEquals": {
# 					"ec2:Subnet": [
# 						"${aws_subnet.dev.arn}"
# 					],
# 					"ec2:AuthorizedService": "codebuild.amazonaws.com"
# 				}
# 			}
# 		},
#
# 		{
# 			"Effect": "Allow",
# 			"Action": [
# 				"s3:*"
# 			],
# 			"Resource": [
# 				"${aws_s3_bucket.cd-edx-artifacts.arn}",
# 				"${aws_s3_bucket.cd-edx-artifacts.arn}/*"
# 			]
# 		}
# 	]
# }
# POLICY
# }
#
# resource "aws_codebuild_project" "unit-test" {
#   name          = "unit-test"
#   description   = "Creates unit tests on python code"
#   build_timeout = "5"
#   service_role  = aws_iam_role.code-build-role.arn
#
#   artifacts {
#     type = "S3"
#     location = aws_s3_bucket.cd-edx-artifacts.bucket
#   }
#
#   cache {
#     type     = "S3"
#     location = aws_s3_bucket.cd-edx-artifacts.bucket
#   }
#
#   environment {
#     compute_type                = "BUILD_GENERAL1_SMALL"
#     image                       = "aws/amazonlinux:2017.09"
#     type                        = "LINUX_CONTAINER"
#     image_pull_credentials_type = "CODEBUILD"
#
#     environment_variable {
#       name  = "SOME_KEY1"
#       value = "SOME_VALUE1"
#     }
#
#     environment_variable {
#       name  = "SOME_KEY2"
#       value = "SOME_VALUE2"
#       type  = "PARAMETER_STORE"
#     }
#   }
#
#   logs_config {
#     cloudwatch_logs {
#       group_name  = "log-group"
#       stream_name = "log-stream"
#     }
#
#     s3_logs {
#       status   = "ENABLED"
#       location = "${aws_s3_bucket.cd-edx-artifacts.id}/build-log"
#     }
#   }
#
#   source {
#     type            = "CODECOMMIT"
#     location        = "edX-Deploying"
#     git_clone_depth = 1
#
#     git_submodules_config {
#       fetch_submodules = true
#     }
#   }
#
#   source_version = "dev"
#
#   vpc_config {
#     vpc_id = aws_vpc.main.id
#
#     subnets = [
#       aws_subnet.dev.id
#     ]
#
#     security_group_ids = [
#       aws_security_group.allow_tls.id
#     ]
#   }
#
#   tags = {
#     Environment = "Test"
#   }
# }
