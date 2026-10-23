output "rds_id" {
  description = "ID of the RDS instance"
  value       = aws_db_instance.this.id
}

output "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = aws_db_instance.this.endpoint
}

output "rds_address" {
  description = "Hostname of the RDS instance"
  value       = aws_db_instance.this.address
}

output "rds_port" {
  description = "Port of the RDS instance"
  value       = aws_db_instance.this.port
}

output "db_subnet_group_name" {
  description = "Name of the DB subnet group"
  value       = aws_db_subnet_group.this.name
}