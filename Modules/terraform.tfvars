region = "us-east-1"

# Network Config
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

# EC2 Config
ami_id        = "ami-0c614dee691cbbf37"
instance_type = "t2.micro"
key_name      = "abhi"
instance_name = "Ishant-EC2"
ebs_size      = 20

# RDS Config
environment = "dev"
namespace   = "myns"

db_name              = "mydatabase"
db_engine            = "postgres"
db_engine_version    = "16"
db_instance_class    = "db.t3.micro"
db_username          = "admin"
db_password          = null
manage_user_password = true

rds_security_group = {
  create      = true
  description = "Security group for RDS instance"
  ingress_rules = [
    {
      description = "Allow PostgreSQL from VPC"
      cidr_block  = "10.0.0.0/16"
      from_port   = 5432
      to_port     = 5432
      ip_protocol = "tcp"
    }
  ]
  egress_rules = [
    {
      description = "Allow all outbound"
      cidr_block  = "0.0.0.0/0"
      from_port   = 0
      to_port     = 0
      ip_protocol = "-1"
    }
  ]
}
