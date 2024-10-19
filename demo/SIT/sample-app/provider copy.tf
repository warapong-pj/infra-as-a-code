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
