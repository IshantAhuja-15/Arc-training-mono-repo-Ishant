variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "instance_name" {
  description = "Name for the EC2 instance"
  type        = string
  default     = "My-EC2-Instance"
}

variable "ebs_size" {
  description = "Size of the EBS volume in GB"
  type        = number
  default     = 10
}
variable "subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}
