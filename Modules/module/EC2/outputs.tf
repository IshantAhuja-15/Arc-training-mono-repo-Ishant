output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.ec2_instance.id
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.ec2_instance.public_ip
}

output "ebs_volume_id" {
  description = "ID of the attached EBS volume"
  value       = aws_ebs_volume.ec2_ebs.id
}
