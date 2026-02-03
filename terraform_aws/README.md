📌 Project Overview

This repository contains an Infrastructure as Code (IaC) implementation using Terraform to provision and manage AWS cloud resources in a reliable, repeatable, and automated manner.

The project demonstrates best practices for structuring Terraform code, separating concerns, and managing cloud infrastructure declaratively.

🏗️ Architecture Components

The Terraform configuration provisions the following AWS resources:
VPC
Custom Virtual Private Cloud
CIDR block configuration

Security Groups
EC2 security group
RDS security group
Controlled inbound and outbound rules

Compute
EC2 instance for application/web hosting

Database
Amazon RDS instance

Networking
VPC-level networking and isolation

Provider Configuration
AWS provider setup with region and credentials

Variables
Centralized and reusable variable definitions

Full Command Flow (Terraform + Git)
Initialize Terraform -> terraform init

Format & validate Terraform code
terraform fmt
terraform validate

Preview infrastructure changes
terraform plan

Apply infrastructure
terraform apply

Check Git status
git status

Stage, commit, and push changes
git add .
git commit -m "Terraform AWS IaC setup with VPC, EC2, RDS, and security groups"
git push

Destroy infrastructure since it's just demonstration
terraform destroy

