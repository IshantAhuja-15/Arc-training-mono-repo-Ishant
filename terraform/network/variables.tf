
variable "environment" {
  type        = string
  description = "dev"
  default     = "poc"
}

variable "region" {
  type        = string
  description = "AWS Region to deploy into"
  default     = "us-east-1"
}

variable "namespace" {
  type        = string
  description = "Namespace"
  default     = "arc"
}
