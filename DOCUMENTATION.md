# AWS Infrastructure Project Documentation

## Overview
This documentation provides detailed information about the AWS infrastructure deployment using Terraform. The project implements a complete cloud infrastructure including networking, compute resources, databases, and monitoring systems.

## Technical Architecture

### 1. Networking (VPC Module)
- VPC CIDR: 10.0.0.0/16
- Availability Zones: ap-south-1a, ap-south-1b
- Public Subnets: 10.0.1.0/24, 10.0.2.0/24
- Private Subnets: 10.0.101.0/24, 10.0.102.0/24
- NAT Gateway for private subnet internet access
- Internet Gateway for public access
- Route tables for public and private subnets

### 2. Compute Resources
- EC2 Instances:
  - Type: t3.micro
  - Count: 2
  - Deployment: Private subnets
  - AMI: Amazon Linux 2
- Load Balancer:
  - Type: Application Load Balancer
  - Listeners: HTTP (80)
  - Target Group: HTTP health checks
  - Security: Web traffic only

### 3. Database
- Engine: MySQL 8.0
- Instance Class: db.t3.micro
- Deployment: Private subnets
- Backup: Automated daily backups
- Security: Private subnet access only

### 4. Security
- Security Groups:
  - Web (ALB): Ports 80/443
  - Application: Custom application ports
  - Database: MySQL port (3306)
- Network ACLs
- IAM Roles and Policies

### 5. Monitoring
- CloudWatch integration
- EC2 instance monitoring
- RDS monitoring
- ALB metrics and logging

## Installation & Setup

### Prerequisites
1. AWS Account
2. AWS CLI configured
3. Terraform >= 1.0.0
4. Git

### Deployment Steps
1. Clone repository
2. Configure AWS credentials
3. Navigate to environment directory:
   ```bash
   cd terraform/envs/dev
   ```
4. Initialize Terraform:
   ```bash
   terraform init
   ```
5. Review changes:
   ```bash
   terraform plan
   ```
6. Apply configuration:
   ```bash
   terraform apply
   ```

## Configuration Guide

### Environment Variables
Required AWS environment variables:
```bash
export AWS_ACCESS_KEY_ID="your_access_key"
export AWS_SECRET_ACCESS_KEY="your_secret_key"
export AWS_DEFAULT_REGION="ap-south-1"
```

### Terraform Variables
Key variables in terraform.tfvars:
```hcl
vpc_cidr = "10.0.0.0/16"
environment = "dev"
project_name = "webapp"
instance_type = "t3.micro"
instance_count = 2
db_instance_class = "db.t3.micro"
```

## Maintenance Guide

### Regular Maintenance Tasks
1. Update AWS provider versions
2. Review security group rules
3. Check CloudWatch metrics
4. Review and rotate access keys
5. Update AMIs as needed

### Backup Procedures
- RDS: Automated daily backups
- EC2: AMI backups as needed
- Configuration: Git repository

### Monitoring
1. CloudWatch Metrics:
   - CPU Utilization
   - Memory Usage
   - Network Traffic
   - Database Connections

2. Alerts:
   - High CPU Usage
   - Low Storage Space
   - Failed Health Checks

## Troubleshooting Guide

### Common Issues

1. VPC Deployment Issues
   - Solution: Verify CIDR ranges
   - Check AZ availability

2. EC2 Connection Issues
   - Check security groups
   - Verify NAT Gateway
   - Validate IAM roles

3. Database Issues
   - Verify subnet configuration
   - Check security group rules
   - Validate credentials

4. Load Balancer Issues
   - Review target group health
   - Check listener configuration
   - Verify security rules

## Security Considerations

1. Network Security:
   - Isolated private subnets
   - Restricted security groups
   - Updated ACLs

2. Access Management:
   - IAM roles per service
   - Least privilege principle
   - Regular key rotation

3. Data Security:
   - Encrypted storage
   - Secure connections
   - Private subnet placement

## Cost Optimization

1. Resource Optimization:
   - Right-sized instances
   - Single NAT Gateway
   - Automated scaling

2. Storage Optimization:
   - Appropriate storage types
   - Lifecycle policies
   - Backup retention

## Support Information

### Contact Information
- Repository Owner: anandkumar6-hub
- Project: terraform-test

### Additional Resources
- AWS Documentation
- Terraform Documentation
- Project Wiki

---

Last Updated: October 24, 2025