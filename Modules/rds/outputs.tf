output "rds_endpoint" {
  value       = aws_db_instance.rds.endpoint
  description = "The connection endpoint for the RDS instance"
}

output "rds_arn" {
  value       = aws_db_instance.rds.arn
  description = "The ARN of the RDS instance"
}

output "rds_sg_id" {
  value       = aws_security_group.rds_sg[*].id
  description = "The ID of the security group created for RDS"
}


output "generated_password" {
  value       = local.master_password
  description = "The RDS master password (generated if not provided)"
  sensitive   = true
}