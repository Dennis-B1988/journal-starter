resource "aws_db_subnet_group" "this" {
  name        = var.db_subnet_group_name
  description = "Subnet group for ${var.identifier}"
  subnet_ids  = var.subnet_ids

  tags = merge(var.tags, {
    Name = var.db_subnet_group_name
  })
}

resource "aws_db_instance" "this" {
  identifier = var.identifier

  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  db_name  = var.db_name
  username = var.username
  password = var.password

  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type
  storage_encrypted = var.storage_encrypted

  multi_az                = var.multi_az
  publicly_accessible     = var.publicly_accessible
  skip_final_snapshot     = var.skip_final_snapshot
  backup_retention_period = var.backup_retention_period
  apply_immediately       = var.apply_immediately

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.vpc_security_group_ids

  depends_on = [
    aws_db_subnet_group.this
  ]

  tags = merge(var.tags, {
    Name = var.identifier
  })
}