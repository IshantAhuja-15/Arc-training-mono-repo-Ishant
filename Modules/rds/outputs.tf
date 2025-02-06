output "rds_endpoint" {
  value       = aws_db_instance.rds.endpoint
}

output "rds_arn" {
  value       = aws_db_instance.rds.arn
  description = "The ARN of the RDS instance"
}

output "rds_sg_id" {
  value       = aws_security_group.rds_sg[*].id
}