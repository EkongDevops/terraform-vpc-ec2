Terraform AWS VPC + EC2 Project
Overview

This project demonstrates Infrastructure as Code (IaC) using Terraform to provision a basic AWS environment. It includes:

▪️VPC with public and private subnets

▪️EC2 instance in the public subnet

▪️Security Groups (modular)

▪️Remote Terraform state in S3

▪️GitHub Actions workflow for automated deployment

▪️tfsec integration for non-blocking security scanning

The project is modular, reusable, and DevSecOps-ready, making it portfolio-ready for Cloud / DevOps roles.

Architecture (ASCII Diagram)
                 +-------------------+
                 |    AWS Account    |
                 +-------------------+
                           |
                           |
                        +-------+
                        |  VPC  |
                        |10.0.0.0/16|
                        +-------+
                   /                \
                  /                  \
         +----------------+    +----------------+
         | Public Subnet  |    | Private Subnet |
         | 10.0.1.0/24    |    | 10.0.2.0/24    |
         +----------------+    +----------------+
                  |
         +----------------+
         | EC2 Instance   |
         | Web Server     |
         +----------------+
                  |
         +----------------+
         | Security Group |
         | HTTP + SSH     |
         +----------------+
                  |
         +----------------+
         | Internet GW    |
         +----------------+

Terraform State: S3 bucket (encrypted)
CI/CD: GitHub Actions (tfsec scan, terraform init/plan/apply)

Repository Structure
terraform-vpc-ec2/
├── .github/
│   └── workflows/
│       └── terraform.yml    # GitHub Actions workflow
├── modules/
│   ├── vpc/
│   ├── ec2/
│   └── security-group/
├── backend.tf               # S3 backend config
├── provider.tf
├── variables.tf
├── outputs.tf
├── main.tf
├── terraform.tfvars
└── README.md


Features:

▪️Modular Terraform code (VPC, EC2, Security Groups)

▪️Remote Terraform state in S3

▪️GitHub Actions CI/CD for automated deployment

▪️tfsec integration for non-blocking security scanning

▪️Clean, reusable, and production-aligned structure



tfsec Scan Output:

[tfsec]  INFO  No critical issues found.
[tfsec]  WARN  Security group allows SSH from 0.0.0.0/0
[tfsec]  INFO  HTTP open to public


Terraform Apply Output

Apply complete! Resources: 5 added, 0 changed, 0 destroyed.


Prerequisites

▪️AWS account with IAM user and programmatic access

▪️S3 bucket for Terraform state

▪️GitHub repository for workflow

▪️Terraform installed locally (>= 1.5)

Optional: AWS CLI configured for local testing (aws configure).

Setup Instructions
1️⃣ Add GitHub Secrets

Add the following in GitHub repo → Settings → Secrets → Actions:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

Optional: AWS_DEFAULT_REGION (if not set in terraform.tfvars)

2️⃣ Configure Terraform Variables

Edit terraform.tfvars:

aws_region           = "eu-north-1"
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidr   = "10.0.1.0/24"
private_subnet_cidr  = "10.0.2.0/24"
instance_type        = "t3.micro"
ami                  = "ami-0c02fb55956c7d316" # Amazon Linux 2

3️⃣ Deployment via GitHub Actions

Push changes to the main branch

GitHub Actions workflow automatically runs:

tfsec scan (soft fail)

terraform init

terraform plan

terraform apply

✅ Check logs for tfsec findings and EC2 public IP in outputs.

4️⃣ Optional: Local Deployment
terraform init
terraform plan
terraform apply -auto-approve


To destroy resources:

terraform destroy -auto-approve


Security Considerations

Security Group allows HTTP (80) from anywhere and SSH (22) for demo purposes. Restrict SSH in production.

tfsec integration ensures visibility of misconfigurations without blocking deployment.


Next Steps / Enhancements

Replace SSH with AWS Systems Manager Session Manager

Lock SSH to your IP only

Add Nginx installation via user_data

Multi-AZ deployment

GitHub OIDC authentication (remove AWS secrets)

Additional security checks using Checkov


References

Terraform Docs

tfsec GitHub

AWS Documentation