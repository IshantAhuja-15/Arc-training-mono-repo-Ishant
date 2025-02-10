terraform {
  required_version = "~> 1.3, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0, < 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# Data sources for AWS VPC and Secrets Manager
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id-ishant"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_secretsmanager_secret" "rds_password" {
  name = "rds-dev-password"
}

data "aws_secretsmanager_secret_version" "rds_password" {
  secret_id = data.aws_secretsmanager_secret.rds_password.id
}

# EC2 Module
module "ec2_instance" {
  source        = "./Modules/EC2"
  ami_id        = "ami-0c614dee691cbbf37"
  instance_type = "t2.micro"
  key_name      = "abhi"
  instance_name = "Ishant-EC2"
  ebs_size      = 20
}

# Network Module
module "network" {
  source = "./Modules/Network"

  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
}

# RDS Module
module "rds" {
  source       = "./rds"
  region       = "us-east-1"
  environment  = "dev"
  namespace    = "my-namespace"
  vpc_id       = data.aws_vpc.default.id
  subnet_ids   = data.aws_subnets.private.ids

  name           = "ishant"
  engine         = "postgres"
  engine_version = "16.3"
  instance_class = "db.t3.small"
  username       = "postgres"
  db_password    = data.aws_secretsmanager_secret_version.rds_password.secret_string

  security_group_data = {
    create      = true
    description = "Security Group for RDS instance-Ishant"
    ingress_rules = [
      {
        description = "Allow traffic from VPC"
        cidr_block  = data.aws_vpc.default.cidr_block
        from_port   = 5432
        ip_protocol = "tcp"
        to_port     = 5432
      }
    ]
    egress_rules = [
      {
        description = "Allow all outbound traffic"
        cidr_block  = "0.0.0.0/0"
        from_port   = 0
        ip_protocol = "0"
        to_port     = -1
      }
    ]
  }
}
