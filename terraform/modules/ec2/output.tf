output "instance_ids" {
  description = "IDs of the EC2 instances"
  value       = aws_instance.this[*].id
}

output "instance_id" {
  description = "ID of the first EC2 instance"
  value       = aws_instance.this[0].id
}

output "public_ips" {
  description = "Public IP addresses of the instances"
  value       = aws_instance.this[*].public_ip
}

output "public_ip" {
  description = "Public IP address of the first instance"
  value       = aws_instance.this[0].public_ip
}

output "eip_addresses" {
  description = "Elastic IP addresses allocated to the instances"
  value       = aws_eip.this[*].public_ip
}

output "eip_allocation_ids" {
  description = "Allocation IDs of the elastic IPs"
  value       = aws_eip.this[*].id
}