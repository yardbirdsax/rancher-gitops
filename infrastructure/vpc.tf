module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "2.64.0"
  providers = {
    aws = aws
  }

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-2a", "us-east-2b", "us-east-2c"]
    public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    deployment = var.deployment_name
  }
}