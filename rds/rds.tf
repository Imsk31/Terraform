resource "aws_security_group" "rds-sg" {
  name_prefix = "MariaDB-"
  ingress {
    from_port   = 0
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "springbackend_rds" {
  engine                 = "mariadb"
  db_name                = "springbackend"
  identifier             = "springbackend"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  publicly_accessible    = true
  multi_az               = true
  username               = var.rds_username
  password               = var.rds_password
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
  skip_final_snapshot    = true

  tags = {
    Name = "springbackend-rds-db-angular-java-project"
  }
}
