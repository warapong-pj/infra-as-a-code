provider "aws" {
  region     = var.region
  access_key = "MOCK_ACCESS_KEY"
  secret_key = "MOCK_SECRET_KEY"

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    iam = "http://localhost:5000"
    sts = "http://localhost:5000"
  }
}

locals {
  tags = {
    Name              = "${var.project}-${var.environment}-${var.name}"
    Owner             = var.owner
    Environment       = var.environment
    ManageByTerraform = "True"
  }
}

module "iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.47.1"

  name        = "${var.project}-${var.environment}-${var.name}"
  path        = "/"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

module "iam-assumable-role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.47.1"

  trusted_role_arns = [
    "arn:aws:iam::307990089504:root",
  ]

  create_role = true
  role_name   = "${var.project}-${var.environment}-${var.name}"

  custom_role_policy_arns = [
    module.iam_policy.arn
  ]
}