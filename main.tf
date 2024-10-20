terraform {
  required_providers {
    aws = {
    source  = "hashicorp/aws"
    version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.provider_region
}

module "aws-ec2-stack" {
  source = "./modules/aws-ec2-stack"
  ec2_instance_count = var.ec2_instance_count
  security_group_ingress_ports = [22, 80]
  security_group_ingress_protocol = "tcp"
  ec2_instance_name = var.ec2_instance_name
  ec2_instance_type = var.ec2_instance_type
  security_group_cidr_blocks = var.security_group_cidr_blocks
  security_group_description = var.security_group_description
  ec2_ami = var.ec2_ami
  ec2_associate_public_ip_address = var.ec2_associate_public_ip_address
  security_group_name = var.security_group_name
  subnet_availability_zone = var.subnet_availability_zone
  vpc_security_group_ids = var.vpc_security_group_ids
}