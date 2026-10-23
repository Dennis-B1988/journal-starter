output "role_arn" {
  description = "ARN of the IAM role"
  value       = aws_iam_role.role.arn

  depends_on = [
    aws_iam_role_policy_attachment.managed_policies,
    aws_iam_role_policy.inline_policies
  ]
}

output "role_name" {
  description = "Name of the IAM role"
  value       = aws_iam_role.role.name
}

output "role_id" {
  description = "ID of the IAM role"
  value       = aws_iam_role.role.id
}