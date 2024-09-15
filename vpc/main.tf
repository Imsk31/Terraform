# Create VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_name
  }
}

# Create Public Subnets
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_a
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = var.public_subnet_name_a
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_b
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = var.public_subnet_name_b
  }
}

# Create Private Subnets
resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_a
  availability_zone = "us-east-1a"

  tags = {
    Name = var.private_subnet_name_a
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_b
  availability_zone = "us-east-1b"

  tags = {
    Name = var.private_subnet_name_b
  }
}

# Create Elastic IP for the NAT Gateway
resource "aws_eip" "nat_eip" {
  vpc = true
}

# Create NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_a.id

  tags = {
    Name = var.nat_gateway_name
  }
}

# Create Route Table for Public Subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public_route_table_name
  }
}

# Associate Public Route Table with Public Subnets
resource "aws_route_table_association" "public_assoc_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_assoc_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

# Create Route Table for Private Subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = var.private_route_table_name
  }
}

# Associate Private Route Table with Private Subnets
resource "aws_route_table_association" "private_assoc_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_assoc_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}

# Create Security Group for Public Instance
resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.public_sg_name
  }
}

# Create Security Group for RDS
resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.rds_sg_name
  }
}

# Create EC2 Instance in Private Subnet (for RDS Management)
resource "aws_instance" "private_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.instance_keypair
  subnet_id     = aws_subnet.private_a.id
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = var.private_instance_name
  }
}

# Create RDS Instance
resource "aws_db_instance" "rds_instance" {
  allocated_storage    = var.rds_allocated_storage
  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  instance_class       = var.rds_instance_class
  db_name              = var.rds_db_name
  username             = var.rds_username
  password             = var.rds_password
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot  = true

  tags = {
    Name = var.rds_instance_name
  }
}

# Create DB Subnet Group for RDS
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.rds_subnet_group_name
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id]

  tags = {
    Name = var.rds_subnet_group_name
  }
}

# Create EC2 Instance in Public Subnet (for Student App)
resource "aws_instance" "public_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.instance_keypair
  subnet_id     = aws_subnet.public_a.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]

  tags = {
    Name = var.public_instance_name
}
}

