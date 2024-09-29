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

  dynamic "ingress" {
    for_each = var.security_group_ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = var.security_group_ingress_protocol
      cidr_blocks = var.security_group_cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "devopspro_tf_ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  associate_public_ip_address = var.ec2_associate_public_ip_address
  key_name      = data.aws_key_pair.devopspro_tf_key.key_name
  count = var.ec2_instance_count

  tags = {
    Name = "${var.ec2_instance_name}-${count.index}"
  }

  subnet_id = aws_subnet.devopspro_tf_subnet.id
  vpc_security_group_ids = [aws_security_group.devopspro_tf_sg.id]

  provisioner "remote-exec" {
    inline = [
      "sudo dnf update -y",
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("/home/rafael/Downloads/devopspro_tf_keypair.pem")
      host = self.public_ip
    }
  }
}