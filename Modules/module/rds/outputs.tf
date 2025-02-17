output "rds_endpoint" {
  value       = aws_db_instance.rds.endpoint
  description = "The connection endpoint for the RDS instance"
}

output "rds_arn" {
  value       = aws_db_instance.rds.arn
  description = "The ARN of the RDS instance"
}

output "rds_sg_id" {
  value       = var.security_group_data.create ? aws_security_group.rds_sg[0].id : ""
  description = "The ID of the security group created for RDS"
}

output "generated_password" {
  value       = coalesce(var.password, random_password.master.result)
  description = "The RDS master password (generated if not provided)"
  sensitive   = true
}
