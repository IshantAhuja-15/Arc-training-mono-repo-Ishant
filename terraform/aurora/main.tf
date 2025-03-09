################################################################################
## defaults
################################################################################
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
  region = var.region
}

module "aurora" {
  source  = "sourcefuse/arc-db/aws"
  version = "4.0.0"

  environment = var.environment
  namespace   = var.namespace
  vpc_id      = data.aws_vpc.vpc.id

  name           = "${var.namespace}-${var.environment}-test"
  engine_type    = "cluster"
  port           = var.db_port
  username       = var.db_username
  engine         = var.db_engine
  engine_version = var.db_engine_version

  license_model = var.db_license_model
  rds_cluster_instances = [
    {
      instance_class          = var.db_instance_class
      db_parameter_group_name = var.db_parameter_group_name
      apply_immediately       = var.apply_immediately
      promotion_tier          = var.promotion_tier
    }
  ]

  db_subnet_group_data = {
    name        = "${var.namespace}-${var.environment}-subnet-group"
    create      = var.create_db_subnet_group
    description = var.db_subnet_group_description
    subnet_ids  = data.aws_subnets.private.ids
  }

  performance_insights_enabled = var.performance_insights_enabled

  kms_data = {
    create                  = var.create_kms_key
    description             = var.kms_description
    deletion_window_in_days = var.kms_deletion_window_in_days
    enable_key_rotation     = var.enable_key_rotation
  }
}
