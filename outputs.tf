output "ec2_public_ip" {
  value = [for instance in aws_instance.devopspro_tf_ec2 : instance.public_ip]
}

output "ec2_instance_id" {
  value = [for instance in aws_instance.devopspro_tf_ec2 : instance.id]
}