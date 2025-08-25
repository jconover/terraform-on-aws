# Terraform AWS EC2 Instance

This Terraform configuration creates a basic EC2 instance on AWS with the following components:

- **EC2 Instance**: t2.micro instance using the latest Amazon Linux 2 AMI
- **VPC**: Custom VPC with public subnet
- **Security Group**: Allows SSH (port 22), HTTP (port 80), and HTTPS (port 443) access
- **Internet Gateway**: For internet connectivity
- **Key Pair**: For SSH access to the instance

## Prerequisites

1. **Terraform**: Install Terraform (version >= 1.2.0)
   - Download from [terraform.io](https://www.terraform.io/downloads.html)
   - Or use package manager: `brew install terraform` (macOS)

2. **AWS CLI**: Install and configure AWS CLI
   - Download from [aws.amazon.com/cli](https://aws.amazon.com/cli/)
   - Configure with: `aws configure`

3. **SSH Key Pair**: Generate an SSH key pair for instance access
   ```bash
   ssh-keygen -t rsa -b 2048 -f private-key/terraform-key
   ```

## Quick Start

1. **Navigate to the Amazon Linux directory**:
   ```bash
   cd amazon-linux
   ```

2. **Copy the template variables file**:
   ```bash
   cp terraform.tfvars.template terraform.tfvars
   ```

3. **Edit terraform.tfvars** with your values:
   ```hcl
   aws_region = "us-east-1"
   project_name = "my-ec2-project"
   ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC..."
   ```

4. **Initialize Terraform**:
   ```bash
   terraform init
   ```

5. **Plan the deployment**:
   ```bash
   terraform plan
   ```

6. **Apply the configuration**:
   ```bash
   terraform apply
   ```

7. **Access your instance**:
   - SSH: `ssh -i private-key/terraform-key ec2-user@<public-ip>`
   - HTTP: Open `http://<public-ip>` in your browser
   - HTTPS: Open `https://<public-ip>` in your browser (requires SSL certificate)

## Configuration Details

### Resources Created

- **VPC**: `10.0.0.0/16` with DNS support enabled
- **Public Subnet**: `10.0.1.0/24` in the first availability zone
- **Internet Gateway**: Connected to the VPC
- **Route Table**: Routes all traffic (0.0.0.0/0) through the Internet Gateway
- **Security Group**: 
  - Inbound: SSH (22), HTTP (80), and HTTPS (443) from anywhere
  - Outbound: All traffic allowed
- **EC2 Instance**: 
  - Instance type: t2.micro
  - AMI: Latest Amazon Linux 2
  - User data: Installs and starts Apache web server

### Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `aws_region` | AWS region for deployment | `us-east-1` |
| `project_name` | Project name for resource tagging | `terraform-ec2` |
| `vpc_cidr` | VPC CIDR block | `10.0.0.0/16` |
| `public_subnet_cidr` | Public subnet CIDR block | `10.0.1.0/24` |
| `ssh_public_key` | SSH public key for instance access | `""` |

## Security Considerations

⚠️ **Important Security Notes**:

1. **SSH Access**: The security group allows SSH access from anywhere (0.0.0.0/0). In production, restrict this to your IP address.

2. **HTTP/HTTPS Access**: Ports 80 and 443 are open to the internet. For production, consider implementing proper SSL certificates and redirecting HTTP to HTTPS.

3. **Key Management**: Store your private key securely and never commit it to version control.

4. **Instance Type**: t2.micro is suitable for testing but may not be sufficient for production workloads.

## Cost Estimation

- **t2.micro instance**: ~$8-10/month (varies by region)
- **VPC, Subnet, IGW**: Free
- **Security Groups**: Free
- **Data transfer**: Varies based on usage

## Cleanup

To destroy all resources and avoid charges:

```bash
terraform destroy
```

## Troubleshooting

### Common Issues

1. **"No AMI found"**: Ensure you're using a supported AWS region
2. **"Invalid key pair"**: Make sure your SSH public key is correctly formatted
3. **"Instance not accessible"**: Check security group rules and route table configuration

### Useful Commands

```bash
# View current state
terraform show

# List all resources
terraform state list

# Refresh state
terraform refresh

# View outputs
terraform output
```

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is open source and available under the [MIT License](LICENSE).
