variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to all resources in the module"
  type        = map(string)
  default     = {}
}

variable "ami" {
  description = "The AMI ID to use for the instance. If not provided, the module will look up the latest Amazon Linux 2 AMI."
  type        = string
  default     = null
}

variable "ami_owners" {
  description = "A list of owners to filter the AMI search. Defaults to Amazon's owner ID."
  type        = list(string)
  default     = ["137112412989"]
}

variable "ami_name_filter" {
  description = "The name filter to use when searching for the latest Amazon Linux 2 AMI. Defaults to 'amzn2-ami-hvm-*-x86_64-gp2'."
  type        = string
  default     = "al2023-ami-2023.*-x86_64"
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = ""
}

variable "instance_count" {
  description = "Number of instances to start"
  type        = number
  default     = 1
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch resources in"
  type        = list(string)
  default     = []
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = []
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with an instance in a VPC"
  type        = bool
  default     = true
}