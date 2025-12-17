terraform {
  backend "s3" {
    bucket  = "vpcec22"
    key     = "vpc-ec2/terraform.tfstate"
    region  = "var.aws_region"
    encrypt = true
  }
}
