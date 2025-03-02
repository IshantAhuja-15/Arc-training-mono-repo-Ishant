
terraform {
  required_version = "~> 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    awsutils = {
      source  = "cloudposse/awsutils"
      version = "~> 0.15"
    }
  }


  backend "s3" {}
}

provider "aws" {
  region = var.region

  default_tags {
    tags = module.tags.tags
  }
}


module "tags" {
  source  = "sourcefuse/arc-tags/aws"
  version = "1.2.3"

  environment = var.environment
  project     = "terraform-aws-ref-arch-network"

  extra_tags = {
    Example = "True"
  }
}


module "network" {

  source = "sourcefuse/arc-network/aws"


  namespace   = var.namespace
  environment = var.environment
  name        = "arc-poc"

  create_internet_gateway = true


  vpc_flow_log_config = {
    enable            = true
    retention_in_days = 7
    s3_bucket_arn     = ""
  }

  availability_zones = ["us-east-1a", "us-east-1b"]
  cidr_block         = "10.0.0.0/16"


  vpc_endpoint_data = [
    {
      service            = "s3"
      route_table_filter = "private"
    },
    {
      service            = "dynamodb"
      route_table_filter = "private"
    }
  ]


  tags = module.tags.tags
}
