terraform {
  required_version = ">= 1.5.0"

 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


# -----------------------------
# VPC Module
# -----------------------------
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr

  tags = var.tags
}

# -----------------------------
# Security Group Module
# -----------------------------
module "security_group" {
  source = "./modules/security-group"

  vpc_id            = module.vpc.vpc_id
  allowed_ssh_cidr  = var.allowed_ssh_cidr
  tags              = var.tags
}


# -----------------------------
# EC2 Module
# -----------------------------
module "ec2" {
  source = "./modules/ec2"

  instance_type      = var.instance_type
  subnet_id          = module.vpc.public_subnet_id
  security_group_ids = [module.security_group.security_group_id]

  tags = var.tags
}
