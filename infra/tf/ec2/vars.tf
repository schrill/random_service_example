variable "tfstate_key" {
  description = "Terraform state key"
}

variable "tfstate_bucket" {
  description = "Terraform state bucket URI"
}

variable "tfstate_bucket_region" {
  description = "Terraform state bucket region"
}

variable "aws_region" {
  description = "The AWS region"
}

variable "aws_account_number" {
  description = "The AWS account number"
}

variable "project_name" {
  description = "The name of the project for which the infra is built"
}

variable "project_env" {
  description = "The env of the project for which the infra is built"
}

variable "rds_uri" {
  description = "The RDS connection URI"
}

variable "rds_sg" {
  description = "The RDS security group been used"
}

variable "private_subnets" {
  description = "The privately declared VPC subnets"
}

variable "instance_type" {
  description = "The type of a EC2 instance"
  default = "t2.micro"
}

#variable "" {
#  description = ""
#}

