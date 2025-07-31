# Resource Block
resource "aws_instance" "ec2demo" {
  #ami           = data.aws_ami.amazon_linux.id
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  user_data = file("${path.module}/app1-install.sh")

  tags = {
    Name = "EC2 Demo"
  }
}

# Output the AMI ID for reference
output "ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "ami_name" {
  value = data.aws_ami.ubuntu.name
}

# Output the AMI ID for reference
#output "ami_id" {
#  value = data.aws_ami.amazon_linux.id
#}

#output "ami_name" {
#  value = data.aws_ami.amazon_linux.name
#}