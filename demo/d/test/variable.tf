variable "region" {
  default = "ap-southeast-1"
}

variable "project" {
  default = "demo"
}

variable "environment" {
  default = "s"
}

variable "name" {
  default = "sample"
}

variable "owner" {
  default = "platform team"
}

variable "policy" {
  default = <<EOF
"{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": [\n        \"s3:*\"\n      ],\n      \"Effect\": \"Allow\",\n      \"Resource\": \"*\"\n    }\n  ]\n}"
EOF
}