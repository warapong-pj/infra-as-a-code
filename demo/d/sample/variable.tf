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
"sample"
EOF
}