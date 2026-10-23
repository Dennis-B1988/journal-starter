variable "name" {
  description = "Base name to be used on all the resources as identifier"
  type        = string
}

variable "env" {
  description = "Name of the environment"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "A list of availability zones in the region, one per subnet"
  type        = list(string)
}

variable "public_subnets" {
  description = "A list of public subnet CIDR blocks inside the VPC"
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of private subnet CIDR blocks inside the VPC"
  type        = list(string)
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3.micro"
}

variable "instance_count" {
  description = "Number of API instances to start"
  type        = number
  default     = 1
}

variable "key_name" {
  description = "Name of the SSH keypair to use, null to not associate one"
  type        = string
  default     = null
}

variable "db_engine" {
  description = "The name of the database engine to be used"
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "The engine version to use for the database"
  type        = string
  default     = "15.19"
}

variable "db_instance_class" {
  description = "The instance type of the database"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "The allocated storage of the database in GB"
  type        = number
  default     = 20
}

variable "db_backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 7
}

variable "db_skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = true
}

variable "db_username" {
  description = "Username for the master DB user"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Password for the master DB user"
  type        = string
  default     = ""
  sensitive   = true
}
