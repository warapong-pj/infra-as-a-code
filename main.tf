variable "region" {
  default = "ap-southeast-1"
}

variable "project" {
  default = "demo"
}

variable "environment" {
  default = "d"
}

variable "name" {
  default = "test"
}

variable "owner" {
  default = "platform-team"
}

provider "aws" {
  region     = var.region
  access_key = "MOCK_ACCESS_KEY"
  secret_key = "MOCK_SECRET_KEY"

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    ec2 = "http://localhost:5000"
    iam = "http://localhost:5000"
    s3  = "http://localhost:5000"
    sts = "http://localhost:5000"
  }
}

locals {
  name = "${var.project}-${var.environment}-${var.name}"
  tags = {
    Name              = "${var.project}-${var.environment}-${var.name}"
    Owner             = var.owner
    Environment       = "SIT"
    ManageByTerraform = "True"
  }
}

module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  bucket = local.name
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }

  tags = local.tags
}
