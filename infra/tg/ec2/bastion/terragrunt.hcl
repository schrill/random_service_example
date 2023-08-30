locals {
  module_name        = "${basename(dirname(get_terragrunt_dir()))}"
  name_prefix        = "${basename(get_terragrunt_dir())}"
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/..//tf/${local.module_name}"
}

include "root" {
  path = find_in_parent_folders()
}

#include "allenv" {
#  path = find_in_parent_folders("allenv.hcl")
#}

include "common" {
  path           = "${get_parent_terragrunt_dir("root")}/..//common.hcl"
  merge_strategy = "deep"
}
