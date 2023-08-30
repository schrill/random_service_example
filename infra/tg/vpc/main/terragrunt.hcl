locals {
  module_name  = "${basename(dirname(get_terragrunt_dir()))}"
}

terraform {
  source = "${get_parent_terragrunt_dir()}/..//tf/${local.module_name}"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  cidr                   = "${get_env("AWS_VPC_CIDR_DEFAULT")}"
  sub_num                = "${get_env("AWS_VPC_SUB_NUM_DEFAULT")}"
}
