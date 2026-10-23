output "eks_id" {
  description = "ID of the EKS cluster"
  value       = aws_eks_cluster.this.id
}

output "name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.this.name
}

output "cluster_security_group_id" {
  description = "AWS-managed EKS cluster security group"
  value       = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}