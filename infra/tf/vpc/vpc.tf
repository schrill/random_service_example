module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = join("-",[var.project_name, var.project_env])
  cidr = var.cidr

  azs              = local.azs
  private_subnets  = local.private_subnets
  public_subnets   = local.public_subnets
  database_subnets = local.database_subnets

  enable_nat_gateway = var.nat
  single_nat_gateway = true
  enable_vpn_gateway = var.vpn
  enable_dns_hostnames = true

  tags = {
    Terraform = "true"
    Project = var.project_name
    Environment = var.project_env
  }
}
