output "ec2_public_ip" {
  value = aws_instance.devopspro_tf_ec2.public_ip
}

output "ec2_instance_id" {
  value = aws_instance.devopspro_tf_ec2.id
}