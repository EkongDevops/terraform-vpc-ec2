module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  tags = {
    Name = "terraform-vpc"
  }
}

module "security_group" {
  source = "./modules/security-group"
  vpc_id = module.vpc.vpc_id
  allowed_ssh_cidr = ["0.0.0.0/0"]
  tags = {
    Name = "terraform-web-sg"
  }
}

module "ec2" {
  source = "./modules/ec2"
  subnet_id          = module.vpc.public_subnet_id
  instance_type      = var.instance_type
  ami                = var.ami
  security_group_ids = [module.security_group.security_group_id]
  tags = {
    Name = "terraform-ec2"
  }
}
