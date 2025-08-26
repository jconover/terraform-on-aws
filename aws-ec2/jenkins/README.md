# Terraform Ubuntu 24.04 EC2 Instance

This Terraform configuration creates a **Ubuntu 24.04 LTS** EC2 instance on AWS with minimal security exposure.

## Key Features

- **Ubuntu 24.04 LTS**: Latest Ubuntu Server release
- **t3.micro instance**: Cost-effective instance type
- **SSH-only access**: Only port 22 is open for security
- **Custom VPC**: Isolated network environment
- **Minimal footprint**: Perfect for development or secure workloads

## Configuration Details

### Resources Created

- **VPC**: `10.0.0.0/16` with DNS support enabled
- **Public Subnet**: `10.0.1.0/24` in the first availability zone
- **Internet Gateway**: Connected to the VPC
- **Route Table**: Routes all traffic (0.0.0.0/0) through the Internet Gateway
- **Security Group**: 
  - Inbound: SSH (22) only
  - Outbound: All traffic allowed
- **EC2 Instance**: 
  - Instance type: t3.micro
  - AMI: Latest Ubuntu 24.04 LTS
  - User data: Updates system packages

## Usage

### Deploy Ubuntu Instance

This configuration is now in its own directory. To deploy:

1. **Navigate to the Ubuntu directory**:
   ```bash
   cd ubuntu
   ```

2. **Set up your variables**:
   ```bash
   cp terraform.tfvars.template terraform.tfvars
   # Edit terraform.tfvars with your SSH public key
   ```

3. **Deploy**:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

### Deploy Both Configurations

To deploy both Amazon Linux and Ubuntu configurations:

```bash
# Deploy Amazon Linux
cd amazon-linux
terraform init && terraform apply

# Deploy Ubuntu (in another terminal or after)
cd ../ubuntu
terraform init && terraform apply
```

## SSH Access

Connect to your Ubuntu instance:
```bash
ssh -i private-key/terraform-key ubuntu@<public-ip>
```

**Note**: Ubuntu uses `ubuntu` as the default username, not `ec2-user`.

## Security Benefits

✅ **Minimal attack surface**: Only SSH port open  
✅ **Latest Ubuntu LTS**: Security updates and long-term support  
✅ **Isolated VPC**: Custom network environment  
✅ **t3.micro**: Cost-effective for development  

## Cost Estimation

- **t3.micro instance**: ~$8-10/month (varies by region)
- **VPC, Subnet, IGW**: Free
- **Security Groups**: Free
- **Data transfer**: Varies based on usage

## Comparison with Amazon Linux Configuration

| Feature | Amazon Linux | Ubuntu 24.04 |
|---------|-------------|--------------|
| Instance Type | t2.micro | t3.micro |
| Open Ports | 22, 80, 443 | 22 only |
| Web Server | Apache (auto-installed) | None |
| Use Case | Web hosting | Development/Secure workloads |
| Security | More permissive | Minimal exposure |

## Cleanup

To destroy Ubuntu resources:
```bash
terraform destroy
```

## Troubleshooting

### Common Issues

1. **"No AMI found"**: Ensure you're using a supported AWS region
2. **"Permission denied"**: Use `ubuntu` username, not `ec2-user`
3. **"Instance not accessible"**: Check security group rules

### Useful Commands

```bash
# View Ubuntu instance details
terraform output ubuntu_instance_public_ip

# SSH command
terraform output ubuntu_ssh_command

# List all resources
terraform state list | grep ubuntu
```
