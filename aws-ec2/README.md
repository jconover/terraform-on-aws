# Terraform AWS EC2 Configurations

This repository contains Terraform configurations for deploying EC2 instances on AWS with different operating systems and configurations.

## Project Structure

```
aws-ec2/
├── amazon-linux/          # Amazon Linux 2 configuration
│   ├── main.tf           # Main Terraform configuration
│   ├── variables.tf      # Variable definitions
│   ├── outputs.tf        # Output values
│   ├── terraform.tfvars.template  # Template for variables
│   └── README.md         # Amazon Linux specific documentation
├── ubuntu/               # Ubuntu 24.04 configuration
│   ├── main.tf           # Main Terraform configuration
│   ├── variables.tf      # Variable definitions
│   ├── outputs.tf        # Output values
│   ├── terraform.tfvars.template  # Template for variables
│   └── README.md         # Ubuntu specific documentation
├── private-key/          # SSH keys (excluded from git)
├── .gitignore           # Git ignore rules
└── README.md            # This file
```

## Available Configurations

### 1. Amazon Linux 2 Configuration (`amazon-linux/`)

**Features:**
- Amazon Linux 2 AMI (latest)
- t2.micro instance type
- Web server ready (Apache auto-installed)
- Ports: 22 (SSH), 80 (HTTP), 443 (HTTPS)
- Perfect for web hosting

**Use Case:** Web applications, development servers, learning environments

### 2. Ubuntu 24.04 Configuration (`ubuntu/`)

**Features:**
- Ubuntu 24.04 LTS AMI (latest)
- t3.micro instance type
- SSH-only access (port 22)
- Minimal security footprint
- Perfect for development and secure workloads

**Use Case:** Development environments, secure workloads, minimal servers

## Quick Start

### Prerequisites

1. **Terraform**: Install Terraform (version >= 1.2.0)
2. **AWS CLI**: Install and configure AWS CLI
3. **SSH Key Pair**: Generate an SSH key pair

### Choose Your Configuration

#### Option 1: Deploy Amazon Linux (Web Server)
```bash
cd amazon-linux
cp terraform.tfvars.template terraform.tfvars
# Edit terraform.tfvars with your SSH public key
terraform init
terraform plan
terraform apply
```

#### Option 2: Deploy Ubuntu (Development Server)
```bash
cd ubuntu
cp terraform.tfvars.template terraform.tfvars
# Edit terraform.tfvars with your SSH public key
terraform init
terraform plan
terraform apply
```

#### Option 3: Deploy Both
```bash
# Deploy Amazon Linux
cd amazon-linux
terraform init && terraform apply

# Deploy Ubuntu (in another terminal or after)
cd ../ubuntu
terraform init && terraform apply
```

## Configuration Comparison

| Feature | Amazon Linux | Ubuntu 24.04 |
|---------|-------------|--------------|
| **AMI** | Amazon Linux 2 | Ubuntu 24.04 LTS |
| **Instance Type** | t2.micro | t3.micro |
| **Open Ports** | 22, 80, 443 | 22 only |
| **Web Server** | Apache (auto-installed) | None |
| **SSH Username** | ec2-user | ubuntu |
| **Use Case** | Web hosting | Development/Secure workloads |
| **Security** | More permissive | Minimal exposure |

## SSH Access

### Amazon Linux
```bash
ssh -i private-key/terraform-key ec2-user@<public-ip>
```

### Ubuntu
```bash
ssh -i private-key/terraform-key ubuntu@<public-ip>
```

## Security Features

✅ **Private Key Management**: Secure SSH key storage  
✅ **Custom VPC**: Isolated network environments  
✅ **Security Groups**: Configurable access control  
✅ **Git Ignore**: Sensitive files excluded from version control  

## Cost Estimation

- **t2.micro**: ~$8-10/month
- **t3.micro**: ~$8-10/month
- **VPC, Subnet, IGW**: Free
- **Security Groups**: Free

## Cleanup

To destroy resources:
```bash
cd <configuration-directory>
terraform destroy
```

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is open source and available under the [MIT License](LICENSE).
