variable "provider_region" {
  default = "us-east-1"
  type = string
  description = "The AWS region in which the resources will be created"
}

variable "ec2_instance_name" {
  default = "DevOpsPro_TF_EC2"
  type = string
  description = "The name of the EC2 instance"
}

variable "ec2_instance_type" {
  default = "t2.micro"
  type = string
  description = "The type of the EC2 instance"
}

variable "ec2_ami" {
  default = "ami-0ebfd941bbafe70c6"
  type = string
  description = "The AMI ID of the EC2 instance"
}

variable "ec2_instance_count" {
  default = 1
  type = number
  description = "The number of EC2 instances to create"
}

variable "ec2_associate_public_ip_address" {
  default = true
  type = bool
  description = "Whether to associate a public IP address with the EC2 instance"
}

variable "vpc_security_group_ids" {
  default = []
  type = list(string)
  description = "The IDs of the security groups to associate with the EC2 instance"
}

variable "subnet_availability_zone" {
  default = "us-east-1a"
  type = string
  description = "The availability zone of the subnet"
}

variable "security_group_name" {
  default = "DevOpsPro_TF_SG"
  type = string
  description = "The name of the security group"
}

variable "security_group_description" {
  default = "Allow inbound traffic on port 22"
  type = string
  description = "The description of the security group"
}

variable "security_group_ingress_from_port" {
  default = 22
  type = number
  description = "The start of the port range for the ingress rule"
}

variable "security_group_ingress_to_port" {
  default = 22
  type = number
  description = "The end of the port range for the ingress rule"
}

variable "security_group_ingress_protocol" {
  default = "tcp"
  type = string
  description = "The protocol for the ingress rule"
}

variable "security_group_cidr_blocks" {
  default = ["0.0.0.0/0"]
  type = list(string)
  description = "The CIDR blocks to allow traffic from"
}