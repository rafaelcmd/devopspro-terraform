data "aws_vpc" "default" {
  default = true
}

data "aws_key_pair" "devopspro_tf_key" {
  key_name = "devopspro_tf_keypair"
}