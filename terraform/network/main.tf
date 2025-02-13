################################################################
## network
################################################################
module "network" {
  source = "https://github.com/sourcefuse/terraform-aws-arc-network"

  namespace   = var.namespace
  environment = var.environment

  name                    = "arc-poc"
  create_internet_gateway = true
  # Enable vpc_flow_logs:If `s3_bucket_arn` is null, CloudWatch logging is enabled by default. If provided, S3 logging is enabled
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