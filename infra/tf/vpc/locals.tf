locals {

  azs                = data.aws_availability_zones.available.names
  azs_count          = length(local.azs)

  public_subnets_gen   = {
                          for i in range(1, 2, 1) : i => [
                            for j in range(10, 10 + local.azs_count, 1) : [
                              cidrsubnet(var.cidr, 8, j)
                            ]
                          ]
                        }

  private_subnets_gen  = {
                          for i in range(1, 2, 1) : i => [
                            for j in range(20, 20 + local.azs_count, 1) : [
                              cidrsubnet(var.cidr, 8, j)
                            ]
                          ]
                        }

  database_subnets_gen = {
                          for i in range(1, 2, 1) : i => [
                            for j in range(30, 30 + local.azs_count, 1) : [
                              cidrsubnet(var.cidr, 8, j)
                            ]
                          ]
                        }


  public_subnets    = var.public_subnets != null ? var.public_subnets : slice(
                        flatten(
                          local.public_subnets_gen[1]
                        ), 0, var.sub_num)

  private_subnets   = var.public_subnets != null ? var.private_subnets : slice(
                        flatten(
                          local.private_subnets_gen[1]
                        ), 0, var.sub_num)

  database_subnets  = var.database_subnets != null ? var.database_subnets : slice(
                        flatten(
                          local.database_subnets_gen[1]
                        ), 0, var.sub_num)

}
