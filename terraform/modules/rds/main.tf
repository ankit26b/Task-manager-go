resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-${var.environment}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = merge(var.tags, {
    Name = "${var.project}-${var.environment}-db-subnet-group"
  })
}

resource "aws_security_group" "this" {
  name        = "${var.project}-${var.environment}-rds-sg"
  description = "RDS access only from EC2 SG"
  vpc_id      = var.vpc_id

  ingress {
    description     = "MySQL from EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.allowed_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.project}-${var.environment}-rds-sg"
  })
}

resource "aws_db_instance" "this" {
  identifier             = "${var.project}-${var.environment}-mysql"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_allocated_storage
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  port                   = 3306
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]

  skip_final_snapshot      = true
  deletion_protection     = var.db_deletion_protection
  backup_retention_period = var.db_backup_retention
  multi_az                = var.db_multi_az
  publicly_accessible     = false
  storage_encrypted       = true

  tags = merge(var.tags, {
    Name = "${var.project}-${var.environment}-mysql"
  })
}
