output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.public_subnets
}

output "database_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.database_subnets
}

output "vpc_id" {
  description = "output for VPC id"
  value       = module.vpc.vpc_id
}

output "azs" {
  description = "output for VPC availability zones"
  value       = slice(module.vpc.azs, 0, var.sub_num)
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "private_subnet_cidr" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "public_subnet_cidr" {
  value = module.vpc.public_subnets_cidr_blocks
}

output "database_subnet_cidr" {
  value = module.vpc.database_subnets_cidr_blocks
}

output "internet_gateway_address" {
  value = module.vpc.igw_id
}

output "nat_gateway_addresses" {
  value = module.vpc.nat_public_ips
}

output "database_subnet_group_id" {
  description = "ID of database subnet group"
  value       = module.vpc.database_subnet_group
}
