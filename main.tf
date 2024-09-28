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
  availability_zone = "us-east-1a"
  cidr_block        = cidrsubnet(data.aws_vpc.default.cidr_block, 4, 2)
}


resource "aws_security_group" "devopspro_tf_sg" {
  name        = "DevOpsPro_TF_SG"
  description = "Allow inbound traffic on port 22 and 80"
  vpc_id      = data.aws_vpc.default.id

    ingress {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "devopspro_tf_ec2" {
  ami           = "ami-0ebfd941bbafe70c6"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name      = data.aws_key_pair.devopspro_tf_key.key_name

  tags = {
    Name = "DevOpsPro_TF_EC2"
  }

  subnet_id = aws_subnet.devopspro_tf_subnet.id
  vpc_security_group_ids = [aws_security_group.devopspro_tf_sg.id]
}