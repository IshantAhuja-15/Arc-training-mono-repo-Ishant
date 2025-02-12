output "bucket_arn" {
  value       = module.bootstrap.bucket_arn
  description = "Bucket's ARN"
}

output "bucket_id" {
  value       = module.bootstrap.bucket_id
  description = "Bucket's ID"
}

output "bucket_name" {
  value       = module.bootstrap.bucket_name
  description = "Bucket's Name"
}

output "dynamodb_arn" {
  value       = module.bootstrap.dynamodb_arn
  description = "DynamoDB's ARN"
}

output "dynamodb_id" {
  value       = module.bootstrap.dynamodb_id
  description = "DynamoDB's ID"
}

output "dynamodb_name" {
  value       = module.bootstrap.dynamodb_name
  description = "DynamoDB's Name"
}