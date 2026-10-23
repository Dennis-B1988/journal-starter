variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to all resources in the module"
  type        = map(string)
  default     = {}
}

variable "role_arn" {
  description = "Existing IAM role to use (specify this, if you don't want to create new IAM role)"
  type        = string
  default     = ""
}

variable "kubernetes_version" {
  description = "Kubernetes version to use"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "A list of subnet IDs inside the VPC"
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  description = "Existing VPC to use (specify this, if you don't want to create new VPC)"
  type        = string
  default     = ""
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 2
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with the EKS cluster"
  type        = list(string)
  default     = []
}