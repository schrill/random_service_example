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

variable "cidr" {
  description = "cidr for vpc"
  default = "10.10.0.0/16"
}

variable "sub_num" {
  description = "Number of subnets to create in individual availability zones"
  default = "3"
}

variable "nat" {
  description = "Enable NAT gateway for the VPC"
  default = "true"
}

variable "vpn" {
  description = "Enable VPN gateway for the VPC"
  default = "false"
}

variable "public_subnets" {
  description = "cidrs for public subnets"
  type        = list(string)
  default     = null
}

variable "private_subnets" {
  description = "cidrs for private subnets"
  type        = list(string)
  default     = null
}

variable "database_subnets" {
  description = "cidrs for database subnets"
  type        = list(string)
  default     = null
}
