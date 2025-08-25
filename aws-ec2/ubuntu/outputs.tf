output "ubuntu_instance_id" {
  description = "ID of the Ubuntu EC2 instance"
  value       = aws_instance.ubuntu_web.id
}

output "ubuntu_instance_public_ip" {
  description = "Public IP address of the Ubuntu EC2 instance"
  value       = aws_instance.ubuntu_web.public_ip
}

output "ubuntu_instance_public_dns" {
  description = "Public DNS name of the Ubuntu EC2 instance"
  value       = aws_instance.ubuntu_web.public_dns
}

output "ubuntu_vpc_id" {
  description = "ID of the Ubuntu VPC"
  value       = aws_vpc.ubuntu_main.id
}

output "ubuntu_security_group_id" {
  description = "ID of the Ubuntu security group"
  value       = aws_security_group.ubuntu_ec2_sg.id
}

output "ubuntu_ssh_command" {
  description = "SSH command to connect to the Ubuntu instance"
  value       = "ssh -i private-key/terraform-key ubuntu@${aws_instance.ubuntu_web.public_ip}"
}
