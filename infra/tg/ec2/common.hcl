dependencies {
  paths = [
            "${get_parent_terragrunt_dir()}/..//vpc/main",
            "${get_parent_terragrunt_dir()}/..//rds/main",
          ]
}

prevent_destroy = false

dependency "vpc" {
  config_path = "${get_parent_terragrunt_dir()}/..//vpc/main"

  mock_outputs = {
    database_subnets      = [ "mock" ]
  }

  mock_outputs_allowed_terraform_commands = [ "validate", "destroy" ]

  skip_outputs = tobool(get_env("DISABLE_INIT", "false"))
}

inputs = {
  private_subnets                    = dependency.vpc.outputs.private_subnets[0]
  rds_uri                            = dependency.rds.outputs.rds_uri
  rds_sg                             = dependency.rds.outputs.rds_sg
}
