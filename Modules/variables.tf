variable "region" {
  type        = string
  description = "AWS region"
}

## Network Variables
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks for private subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
}

## EC2 Variables
variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "key_name" {
  type        = string
  description = "Key pair name for SSH access"
}

variable "instance_name" {
  type        = string
  description = "Name for the EC2 instance"
}

variable "ebs_size" {
  type        = number
  description = "Size of the EBS volume in GB"
}

## RDS Variables

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "namespace" {
  type        = string
  description = "Namespace for resource naming"
}

## RDS Variables
variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_engine" {
  type        = string
  description = "Database engine type"
}

variable "db_engine_version" {
  type        = string
  description = "Database engine version"
}

variable "db_instance_class" {
  type        = string
  description = "Database instance type"
}

variable "db_username" {
  type        = string
  description = "Database username"
}

variable "db_password" {
  type        = string
  description = "Database password (if not managed automatically)"
  default     = null
  sensitive   = true
}

variable "manage_user_password" {
  type        = bool
  description = "If true, a random password will be generated if no password is provided."
}


variable "rds_security_group" {
  type = object({
    create      = bool
    description = string
    ingress_rules = list(object({
      description = string
      cidr_block  = string
      from_port   = number
      to_port     = number
      ip_protocol = string
    }))
    egress_rules = list(object({
      description = string
      cidr_block  = string
      from_port   = number
      to_port     = number
      ip_protocol = string
    }))
  })
  description = "Security group configuration for RDS"
}
