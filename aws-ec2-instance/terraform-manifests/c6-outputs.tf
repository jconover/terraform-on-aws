# Terraform Output Values

# EC2 Instance Public IP
output "instance_publicip" {
  description = "EC2 Instance Public IP"
  value = aws_instance.ec2demo.public_ip
}

# EC2 Instance Public DNS
output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  value = aws_instance.ec2demo.public_dns
}

# Output the AMI ID for reference
#output "ami_id" {
#  value = data.aws_ami.ubuntu.id
#}

#output "ami_name" {
#  value = data.aws_ami.ubuntu.name
#}

# Output the AMI ID for reference
output "ami_id" {
  value = data.aws_ami.amazon_linux.id
}
output "ami_name" {
  value = data.aws_ami.amazon_linux.name
}