locals {
  project_repo_name = get_env("CI_PROJECT_TITLE")
  project_name      = "${trimsuffix(local.project_repo_name, "-infra")}"
  project_env       = get_env("CI_ENVIRONMENT_NAME")
  aws_region        = get_env("AWS_DEFAULT_REGION", "us-east-1")
  name_prefix       = get_aws_account_id()
}

remote_state {
  backend = "s3"
  disable_init = tobool(get_env("DISABLE_INIT", "false"))
  disable_dependency_optimization = tobool(get_env("DISABLE_INIT", "false"))

  config  = {
    encrypt        = true
    bucket         = "${local.project_name}-tfstate-${local.project_env}-${local.name_prefix}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    dynamodb_table = "${local.project_name}-tflock-${local.project_env}-${local.name_prefix}"
    s3_bucket_tags ={
      Terraform = "true"
      Environment = local.project_env
    }
  }
}

inputs = {
  tfstate_key           = "${path_relative_to_include()}/../"
  tfstate_bucket        = "${local.project_name}-tfstate-${local.project_env}-${local.name_prefix}"
  tfstate_bucket_region = local.aws_region
  aws_region            = local.aws_region
  aws_account_number    = local.name_prefix
  dynamodb_table        = "${local.project_name}-tflock-${local.project_env}-${local.name_prefix}"
  project_name          = local.project_name
  project_env           = local.project_env
}

