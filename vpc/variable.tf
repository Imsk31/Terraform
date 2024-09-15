variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_a" {
  description = "Public subnet CIDR block in AZ a"
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr_b" {
  description = "Public subnet CIDR block in AZ b"
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr_a" {
  description = "Private subnet CIDR block in AZ a"
  default     = "10.0.3.0/24"
}

variable "private_subnet_cidr_b" {
  description = "Private subnet CIDR block in AZ b"
  default     = "10.0.4.0/24"
}

variable "vpc_name" {
  description = "Name for the VPC"
  default     = "Terrafor-project-vpc"
}

variable "igw_name" {
  description = "Name for the Internet Gateway"
  default     = "main-igw"
}

variable "public_subnet_name_a" {
  description = "Name for the public subnet in AZ a"
  default     = "public-subnet-a"
}

variable "public_subnet_name_b" {
  description = "Name for the public subnet in AZ b"
  default     = "public-subnet-b"
}

variable "private_subnet_name_a" {
  description = "Name for the private subnet in AZ a"
  default     = "private-subnet-a"
}

variable "private_subnet_name_b" {
  description = "Name for the private subnet in AZ b"
  default     = "private-subnet-b"
}

variable "nat_gateway_name" {
  description = "Name for the NAT Gateway"
  default     = "main-nat"
}

variable "public_route_table_name" {
  description = "Name for the public route table"
  default     = "main-public-route-table"
}

variable "private_route_table_name" {
  description = "Name for the private route table"
  default     = "main-private-route-table"
}

variable "public_sg_name" {
  description = "Name for the public security group"
  default     = "public-sg"
}

variable "rds_sg_name" {
  description = "Name for the RDS security group"
  default     = "rds-sg"
}

variable "private_instance_name" {
  description = "Name for the private EC2 instance"
  default     = "private-instance"
}

variable "rds_instance_name" {
  description = "Name for the RDS instance"
  default     = "main-rds"
}

variable "rds_subnet_group_name" {
  description = "Name for the RDS subnet group"
  default     = "rds-subnet-group"
}

variable "public_instance_name" {
  description = "Name for the public EC2 instance"
  default     = "public-instance"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  default     = "ami-04a81a99f5ec58529"  # Update with a valid AMI ID
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  default     = "t2.micro"
}

variable "rds_allocated_storage" {
  description = "Allocated storage for the RDS instance"
  default     = 20
}

variable "rds_engine" {
  description = "Database engine for the RDS instance"
  default     = "mysql"
}

variable "rds_instance_class" {
  description = "Instance class for the RDS instance"
  default     = "db.t3.micro"  # Update to a supported instance class
}

variable "rds_engine_version" {
  description = "Database engine version for the RDS instance"
  default     = "8.0"  # Update to a supported engine version
}

variable "rds_db_name" {
  description = "Database name for the RDS instance"
  default     = "terraform_project_DB"
}

variable "rds_username" {
  description = "Master username for the RDS instance"
  default     = "admin"
}

variable "rds_password" {
  description = "Master password for the RDS instance"
  default     = "admin123"  # Update with a strong password
}

variable "instance_keypair" {
  description = "key-pair name for instance"
  default     = "new"  # Update with a strong password
}


