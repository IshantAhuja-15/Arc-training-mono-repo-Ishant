################################################################################
## shared variables
################################################################################

variable "region" {
  type        = string
  description = "AWS region where resources will be created"
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g., dev, staging, prod)"
}

variable "namespace" {
  type        = string
  description = "Namespace to prefix resource names"
}

variable "db_port" {
  type        = number
  description = "Port for the Aurora DB"
}

variable "db_username" {
  type        = string
  description = "Username for the database"
}

variable "db_engine" {
  type        = string
  description = "Database engine (e.g., aurora-postgresql)"
}

variable "db_engine_version" {
  type        = string
  description = "Database engine version (e.g., 16.2)"
}

variable "db_license_model" {
  type        = string
  description = "License model for the database"
}

variable "db_instance_class" {
  type        = string
  description = "Instance class for the database cluster"
}

variable "db_parameter_group_name" {
  type        = string
  description = "Name of the DB parameter group"
}

variable "apply_immediately" {
  type        = bool
  description = "Apply changes immediately or wait for the maintenance window"
}

variable "promotion_tier" {
  type        = number
  description = "Promotion tier for the instance"
}

variable "create_db_subnet_group" {
  type        = bool
  description = "Flag to create a new DB subnet group"
}

variable "db_subnet_group_description" {
  type        = string
  description = "Description for the DB subnet group"
}

variable "performance_insights_enabled" {
  type        = bool
  description = "Enable performance insights"
}

variable "create_kms_key" {
  type        = bool
  description = "Create a new KMS key for encryption"
}

variable "kms_description" {
  type        = string
  description = "Description of the KMS key"
}

variable "kms_deletion_window_in_days" {
  type        = number
  description = "Retention period for the KMS key"
}

variable "enable_key_rotation" {
  type        = bool
  description = "Enable automatic key rotation"
}
