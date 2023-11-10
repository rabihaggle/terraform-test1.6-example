# Create a VPC

module "vpc" {
  version                = "~>5.1.1"
  source                 = "terraform-aws-modules/vpc/aws"
  name                   = "${local.settings.team}-${local.settings.environment}"
  cidr                   = local.settings.vpc.cidr_block
  azs                    = data.aws_availability_zones.this.names
  private_subnets        = local.settings.vpc.private_subnet_cidrs
  public_subnets         = local.settings.vpc.public_subnet_cidrs
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = false
  enable_dns_hostnames   = true
}