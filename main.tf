module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_cidr  = var.private_subnet_cidr
  tags = {
    Name = "terraform-vpc"
  }
}

module "ec2" {
  source        = "./modules/ec2"
  subnet_id     = module.vpc.public_subnet_id
  instance_type = var.instance_type
  ami           = var.ami

  tags = {
    Name = "terraform-ec2"
  }
}
