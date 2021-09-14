locals {
  port = var.port != null ? var.port : (var.engine == "mysql" ? 3306 : 5432)
}

resource "aws_db_subnet_group" "private" {
  name       = "${var.name}-database"
  subnet_ids = var.subnets
}

resource "aws_kms_key" "key" {
  count       = var.enable_encryption ? 1 : 0
  description = "RDS encryption key for ${var.name}-database"
}

resource "aws_security_group" "database" {
  name   = "${var.name}-database"
  vpc_id = var.vpc_id

  ingress {
    from_port       = local.port
    to_port         = local.port
    protocol        = "tcp"
    security_groups = var.security_groups
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "publicly_accessible" {
  count = var.publicly_accessible ? 1 : 0

  security_group_id = aws_security_group.database.id
  type              = "ingress"
  from_port         = local.port
  to_port           = local.port
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "tcp"
}

resource "aws_db_instance" "database" {
  allocated_storage       = var.allocated_storage
  max_allocated_storage   = var.max_allocated_storage
  backup_retention_period = var.backup_retention_period
  db_subnet_group_name    = aws_db_subnet_group.private.name
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  identifier              = var.identifier
  name                    = var.name
  password                = var.password
  skip_final_snapshot     = true
  storage_type            = var.storage_type
  username                = var.username
  vpc_security_group_ids  = [aws_security_group.database.id]
  kms_key_id              = var.enable_encryption ? aws_kms_key.key[0].arn : null
  storage_encrypted       = var.enable_encryption
  port                    = local.port
  publicly_accessible     = var.publicly_accessible
}
