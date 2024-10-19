locals {
  tags = {
    Name              = "${var.project}-${var.environment}-${var.name}"
    Owner             = var.owner
    Environment       = var.environment
    ManageByTerraform = "True"
  }
}

module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  bucket = "${var.project}-${var.environment}-${var.name}"
  acl    = var.acl

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }

  tags = local.tags
}
