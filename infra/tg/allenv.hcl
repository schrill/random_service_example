locals {
  root_vars      = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))  
  project_name   = local.root_vars.locals.project_name
  aws_region     = local.root_vars.locals.aws_region
  name_prefix    = "${get_env("AWS_ALL_ACCOUNT_RESOURCE_ID", "146353819743")}"
}

prevent_destroy = true

remote_state {
  backend = "s3"
  disable_init = tobool(get_env("DISABLE_INIT", "false"))
  disable_dependency_optimization = tobool(get_env("DISABLE_INIT", "false"))


  config  = {
    encrypt        = true
    bucket         = "${local.project_name}-tfstate-allenv-${local.name_prefix}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    dynamodb_table = "${local.project_name}-tflock-allenv-${local.name_prefix}"
  }
}

iam_role = "${get_env("AWS_ALL_ACCOUNT_RESOURCE_IAM_ASSUME", "")}"

inputs = {
  tfstate_bucket          = "${local.project_name}-tfstate-allenv-${local.name_prefix}"
  dynamodb_table          = "${local.project_name}-tflock-allenv-${local.name_prefix}"
}
