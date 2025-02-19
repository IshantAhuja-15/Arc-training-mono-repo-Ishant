resource "aws_security_group" "rds_sg" {
  count       = var.security_group_data.create ? 1 : 0
  name        = "${var.namespace}-${var.environment}-rds-sg"
  description = var.security_group_data.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.security_group_data.ingress_rules
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["ip_protocol"]
      cidr_blocks = [ingress.value["cidr_block"]]
    }
  }

  dynamic "egress" {
    for_each = var.security_group_data.egress_rules
    content {
      description = egress.value["description"]
      from_port   = egress.value["from_port"]
      to_port     = egress.value["to_port"]
      protocol    = egress.value["ip_protocol"]
      cidr_blocks = [egress.value["cidr_block"]]
    }
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.namespace}-${var.environment}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "random_password" "master" {
  length           = 16
  special          = true
  override_special = "!#$%^&*()-_=+[]{}|;:,.<>?"
}

resource "aws_ssm_parameter" "db_password" {
  count = var.manage_user_password ? 1 : 0

  name  = "/${var.environment}/${var.namespace}/db/password"
  type  = "SecureString"
  value = random_password.master.result

  tags = {
    Name = "db-password"
  }
}

resource "aws_db_instance" "rds" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.name
  username               = var.username
  password               = coalesce(var.password, random_password.master.result)
  parameter_group_name   = "default.postgres16"
  publicly_accessible    = false
  vpc_security_group_ids = var.security_group_data.create ? [aws_security_group.rds_sg[0].id] : []
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot    = true
}
