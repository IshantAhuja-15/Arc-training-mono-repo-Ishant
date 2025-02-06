provider "aws" {
  region = "us-east-1"  
}

module "ec2_instance" {
  source        = "./Modules/EC2"
  ami_id        = "ami-0c614dee691cbbf37"
  instance_type = "t2.micro"
  key_name      = "abhi"  
  instance_name = "Ishant-EC2"
  ebs_size      = 20
}

module "network" {
  source = "./Modules/Network"

  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
}