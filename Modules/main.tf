provider "aws" {
  region = var.region
}

module "network" {
  source = "./module/Network"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "ec2_instance" {
  source        = "./module/EC2"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  instance_name = var.instance_name
  ebs_size      = var.ebs_size
  subnet_id     = module.network.public_subnet_ids[0]
  vpc_id        = module.network.vpc_id
}

module "rds" {
  source      = "./module/rds"
  region      = var.region
  environment = var.environment
  namespace   = var.namespace

  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.private_subnet_ids

  name                 = var.db_name
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  username             = var.db_username
  password             = var.db_password
  manage_user_password = var.manage_user_password

  security_group_data = var.rds_security_group
}
