output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.this.cidr_block
}

output "igw_id" {
  description = "ID of the internet gateway"
  value       = aws_internet_gateway.this.id
}