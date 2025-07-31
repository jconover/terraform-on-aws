# EC2 Instance

# Resource Block
resource "aws_instance" "ec2demo" {
  ami                    = data.aws_ami.amazon_linux.id
  #ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.aws_instance_type
  user_data              = file("${path.module}/app1-install.sh")
  #key_name               = var.aws_key_pair
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]

  tags = {
    Name = "EC2 Demo"
  }
}

