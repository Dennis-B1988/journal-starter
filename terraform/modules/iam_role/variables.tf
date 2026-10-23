variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to all resources in the module"
  type        = map(string)
  default     = {}
}

variable "description" {
  description = "Description of the role"
  type        = string
  default     = ""
}

variable "assume_role_policy" {
  description = "Assume role policy document (JSON)"
  type        = string
}

variable "managed_policy_arns" {
  description = "List of managed policy ARNs to attach"
  type        = list(string)
  default     = []
}

variable "inline_policies" {
  description = "Map of inline policy names to policy documents"
  type        = map(string)
  default     = {}
}

variable "max_session_duration" {
  description = "Maximum session duration in seconds"
  type        = number
  default     = 3600
}

variable "path" {
  description = "Path for the role"
  type        = string
  default     = "/"
}

variable "permissions_boundary" {
  description = "ARN of permissions boundary policy"
  type        = string
  default     = null
}