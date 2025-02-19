variable "region" {
  type        = string
  description = "AWS region"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "namespace" {
  type        = string
  description = "Namespace for resource naming"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where resources will be created"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the RDS subnet group"
}

variable "name" {
  type        = string
  description = "Database name"
}

variable "engine" {
  type        = string
  description = "Database engine type"
}

variable "engine_version" {
  type        = string
  description = "Database engine version"
}

variable "instance_class" {
  type        = string
  description = "Database instance type"
}

variable "username" {
  type        = string
  description = "Database username"
}

variable "password" {
  type        = string
  description = "Master password for the RDS instance. If not provided and manage_user_password is true, a random password will be generated."
  default     = null
  sensitive   = true
}

variable "manage_user_password" {
  type        = bool
  description = "If true, a random password will be generated if no password is provided."
  default     = false
}

variable "security_group_data" {
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
