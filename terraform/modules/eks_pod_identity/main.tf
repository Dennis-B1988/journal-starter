resource "aws_eks_pod_identity_association" "this" {
  cluster_name    = var.name
  namespace       = var.namespace
  service_account = var.service_account
  role_arn        = var.role_arn

  tags = merge(var.tags, {
    Name = "${var.name}-${var.service_account}"
  })
}