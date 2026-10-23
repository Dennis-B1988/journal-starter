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

variable "namespace" {
  description = "Kubernetes namespace for the pod identity association"
  type        = string
  default     = "default"
}

variable "service_account" {
  description = "Kubernetes service account for the pod identity association"
  type        = string
  default     = "journal-api"
}