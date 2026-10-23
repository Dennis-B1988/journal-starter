variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to all resources in the module"
  type        = map(string)
  default     = {}
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = ""
}

variable "role_arn" {
  description = "Existing IAM role to use (specify this, if you don't want to create new IAM role)"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "A list of subnet IDs inside the VPC"
  type        = list(string)
  default     = []
}

variable "instance_types" {
  description = "A list of instance types for the node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "capacity_type" {
  description = "The capacity type of the node group. Valid values are 'ON_DEMAND' or 'SPOT'."
  type        = string
  default     = "ON_DEMAND"
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

variable "addon_name" {
  description = "Name of the EKS addon to be installed in the node group"
  type        = string
  default     = ""
}

variable "addon_version" {
  description = "Version of the EKS addon to be installed in the node group"
  type        = string
  default     = "1.0.0"
}