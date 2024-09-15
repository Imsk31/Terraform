# Output VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

# Output Internet Gateway ID
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

# Output Public Subnet IDs
output "public_subnet_ids" {
  description = "The IDs of the Public Subnets"
  value       = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

# Output Private Subnet IDs
output "private_subnet_ids" {
  description = "The IDs of the Private Subnets"
  value       = [aws_subnet.private_a.id, aws_subnet.private_b.id]
}

# Output NAT Gateway ID
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.nat.id
}

# Output Security Group ID for Public Instance
output "public_security_group_id" {
  description = "The ID of the Security Group for the Public Instance"
  value       = aws_security_group.public_sg.id
}

# Output Security Group ID for RDS
output "rds_security_group_id" {
  description = "The ID of the Security Group for the RDS Instance"
  value       = aws_security_group.rds_sg.id
}

# Output Public EC2 Instance ID
output "public_instance_id" {
  description = "The ID of the Public EC2 Instance"
  value       = aws_instance.public_instance.id
}

# Output Private EC2 Instance ID
output "private_instance_id" {
  description = "The ID of the Private EC2 Instance"
  value       = aws_instance.private_instance.id
}

# Output RDS Instance Endpoint
output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.rds_instance.endpoint
}

# Output RDS Instance ARN
output "rds_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.rds_instance.arn
}

