variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "description" {
  description = "Description of the security group"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Additional tags to apply to all resources in the module"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "Existing VPC to use (specify this, if you don't want to create new VPC)"
  type        = string
  default     = ""
}

variable "ingress_rules" {
  description = "List of ingress rules to create by name"
  type = map(object({
    description                  = optional(string)
    port                         = optional(number)
    protocol                     = optional(string, "tcp")
    cidr_ipv4                    = optional(string)
    referenced_security_group_id = optional(string)
  }))
  default = {}
}

variable "egress_rules" {
  type = map(object({
    description                  = optional(string)
    port                         = optional(number)
    protocol                     = optional(string, "tcp")
    cidr_ipv4                    = optional(string)
    referenced_security_group_id = optional(string)
  }))
  default = {}
}