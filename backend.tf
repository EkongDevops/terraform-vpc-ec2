terraform {
  backend "s3" {
    bucket  = "vpcec22"
    key     = "vpc-ec2/terraform.tfstate"
    region  = "eu-north-1"
    encrypt = true
  }
}
