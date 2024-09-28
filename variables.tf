variable "provider_region" {
  default = "us-east-1"
}

variable "ec2_instance_name" {
  default = "DevOpsPro_TF_EC2"
}

variable "ec2_instance_type" {
  default = "t2.micro"
}

variable "ec2_ami" {
  default = "ami-0ebfd941bbafe70c6"
}

variable "subnet_availability_zone" {
  default = "us-east-1a"
}