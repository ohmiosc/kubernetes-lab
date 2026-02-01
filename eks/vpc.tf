########################
# Data
########################
data "aws_caller_identity" "current" {}

######


########################################
# Elastic IP - 1 por AZ
########################################
resource "aws_eip" "nat" {
  for_each = var.create_vpc ? toset(var.zone_azs) : toset([])

  domain = "vpc"

  tags = {
    Name        = "nat-eip-${var.environment}-${each.key}"
    Environment = var.environment
  }
}

########################################
# VPC Module
########################################
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"
  # Crear solo en ciertos ambientes
  count = var.create_vpc ? 1 : 0 

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.zone_azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  ################################
  # NAT Gateway - 1 por AZ
  ################################
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  ################################
  # Attach EIPs creados arriba
  ################################
  external_nat_ip_ids = values(aws_eip.nat)[*].id

  ################################
  # DNS
  ################################
  enable_dns_hostnames = true
  enable_dns_support   = true

  ################################
  # Tags
  ################################
  tags = {
    Environment = var.environment
    Terraform   = "true"
  }

  # public_subnet_tags = {
  #   "kubernetes.io/role/elb" = "1"
  # }

  # private_subnet_tags = {
  #   "kubernetes.io/role/internal-elb" = "1"
  # }
}