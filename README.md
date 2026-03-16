# AWS Networking Infrastructure with Terraform

![Architecture Diagram](diagram.png)

## Architecture Diagram (Mermaid)

```mermaid
graph TD
    subgraph VPC ["VPC: 10.0.0.0/16"]
        direction TB
        IGW["Internet Gateway"]
        
        subgraph PublicSubnet1 ["Public Subnet 1 (10.0.1.0/24)"]
            ALB["Application Load Balancer"]
            NAT["NAT Gateway"]
        end

        subgraph PublicSubnet2 ["Public Subnet 2 (10.0.2.0/24)"]
            TG["Target Group"]
        end

        subgraph PrivateSubnet ["Private Subnet (10.0.3.0/24)"]
            EC2["EC2 Instance (Apache)"]
        end
    end

    Users((Users)) -->|HTTP:80| IGW
    IGW --> ALB
    ALB --> TG
    TG --> EC2
    EC2 -->|Outbound| NAT
    NAT --> IGW

    style VPC fill:#f9f9f9,stroke:#333,stroke-width:2px
    style PublicSubnet1 fill:#e1f5fe,stroke:#01579b
    style PublicSubnet2 fill:#e1f5fe,stroke:#01579b
    style PrivateSubnet fill:#fff3e0,stroke:#e65100
```


## Architecture Overview
The infrastructure includes:
- **VPC**: A Virtual Private Cloud with CIDR `10.0.0.0/16`.
- **Public Subnets**: Two public subnets in different Availability Zones for high availability of the Load Balancer.
- **Private Subnet**: One private subnet where the application (EC2 instance) resides.
- **Internet Gateway (IGW)**: Provides internet access for public subnets.
- **NAT Gateway**: Located in a public subnet to allow instances in the private subnet to access the internet (e.g., for software updates).
- **Application Load Balancer (ALB)**: Distributes incoming HTTP traffic across the EC2 instances.
- **EC2 Instance**: A web server running Apache in the private subnet.
- **Security Groups**:
    - `alb_sg`: Allows HTTP traffic (Port 80) from the internet.
    - `ec2_sg`: Allows HTTP traffic (Port 80) only from the ALB.

## Project Structure

```text
.
├── alb.tf              # Application Load Balancer and Target Group
├── ec2.tf              # EC2 instance and Target Group attachment
├── nat.tf              # NAT Gateway and Elastic IP
├── outputs.tf          # Terraform output variables (e.g., ALB DNS)
├── providers.tf        # AWS provider configuration
├── security_groups.tf  # Security Group definitions
├── variables.tf        # Variable definitions and defaults
└── vpc.tf              # VPC, subnets, IGW, and route tables
```

## Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed.
- AWS CLI configured with appropriate credentials.

### Deployment

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Check the Plan**:
   ```bash
   terraform plan
   ```

3. **Apply the Configuration**:
   ```bash
   terraform apply
   ```

## Verification

After the deployment is complete, Terraform will output the `alb_dns_name`. You can visit this URL in your browser to see the "Hello from Antigravity EC2 in Private Subnet" message.

