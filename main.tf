terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_subnet" "devopspro_tf_subnet" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = var.subnet_availability_zone
  cidr_block        = cidrsubnet(data.aws_vpc.default.cidr_block, 4, 2)
}


resource "aws_security_group" "devopspro_tf_sg" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = data.aws_vpc.default.id

    ingress {
      from_port = var.security_group_ingress_from_port
      to_port   = var.security_group_ingress_to_port
      protocol  = var.security_group_ingress_protocol
      cidr_blocks = var.security_group_cidr_blocks
    }
}

resource "aws_instance" "devopspro_tf_ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  associate_public_ip_address = var.ec2_associate_public_ip_address
  key_name      = data.aws_key_pair.devopspro_tf_key.key_name
  count = var.ec2_instance_count

  tags = {
    Name = var.ec2_instance_name
  }

  subnet_id = aws_subnet.devopspro_tf_subnet.id
  vpc_security_group_ids = [aws_security_group.devopspro_tf_sg.id]
}