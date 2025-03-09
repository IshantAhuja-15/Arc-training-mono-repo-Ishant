region      = "ap-south-1"
environment = "poc"
namespace   = "arc"

db_port           = 5432
db_username       = "postgres"
db_engine         = "aurora-postgresql"
db_engine_version = "16.2"

db_license_model        = "postgresql-license"
db_instance_class       = "db.t3.medium"
db_parameter_group_name = "default.aurora-postgresql16"
apply_immediately       = true
promotion_tier          = 1

create_db_subnet_group      = true
db_subnet_group_description = "Subnet group for RDS instance"

performance_insights_enabled = true

create_kms_key              = true
kms_description             = "KMS for Performance Insight and storage"
kms_deletion_window_in_days = 7
enable_key_rotation         = true
