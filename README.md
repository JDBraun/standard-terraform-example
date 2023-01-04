# Standard Workspace + Unity Catalog Deployment Example


- This example is meant to be an example to assist with trials, proof of concepts, and a foundation for production deployments. 
- There are no guarantees or warranties associated with this example.

# Terraform Script

- **Data Plane Creation:**
    - Workspace Subnets
    - Security Groups
    - NACLs
    - Route Tables
    - AWS VPC Endpoints (S3, Kinesis, STS, Databricks Endpoints)
    - S3 Root Bucket
    - Cross Account - IAM Role
    - S3 Instance Profile - IAM Role
    - External Location - IAM Role

- **Workspace Deployment:**
    - Credential Configuration
    - Storage Configuration
    - Network Configuration (Backend PrivateLink Enabled)

- **Post Workspace Deployment:**
    - Data Engineering Cluster 
    - Instance Profile Registration

- **Post Workspace Deployment:**
    - Unity Catalog - Metastore
    - External Location 

# Getting Started

1. Clone this Repo 

2. Install [Terraform](https://developer.hashicorp.com/terraform/downloads)

3. Fill out `example.tfvars` and place in `aws-wl` directory

5. CD into `aws`

5. Run `terraform init`

6. Run `terraform validate`

7. From `aws` directory, run `terraform plan -var-file ../example.tfvars`

8. Run `terraform apply -var-file ../example.tfvars`


# Network Diagram

![Architecture Diagram](https://github.com/JDBraun/standard-terraform-example/blob/master/img/Standard%20-%20Network%20Topology.png)