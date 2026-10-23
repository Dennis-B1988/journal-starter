output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "api_id" {
  description = "ID of the EC2 instance"
  value       = module.api_ec2.instance_id
}

output "api_db_id" {
  description = "ID of the RDS instance"
  value       = module.api_db.rds_id
}

output "db_connect" {
  description = "Endpoint of the RDS instance"
  value       = "psql -h ${module.api_db.rds_endpoint} -p 5432 -U postgres"
}