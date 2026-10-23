variable "identifier" {
  description = "The name of the RDS instance"
  type        = string
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created"
  type        = string
  default     = ""
}

variable "engine" {
  description = "The name of the database engine to be used"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "15.19"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = "postgres"
}

variable "password" {
  description = "Password for the master DB user"
  type        = string
  default     = ""
  sensitive   = true
}

variable "allocated_storage" {
  description = "The allocated storage in GB"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "The storage type of the RDS instance"
  type        = string
  default     = "gp2"
}

variable "storage_encrypted" {
  description = "Whether the storage of the RDS instance is encrypted"
  type        = bool
  default     = true
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Whether the RDS instance is publicly accessible"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 7
}

variable "apply_immediately" {
  description = "Determines whether modifications are applied immediately"
  type        = bool
  default     = false
}

variable "db_subnet_group_name" {
  description = "The DB subnet group name"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "A list of subnet IDs the DB subnet group spans"
  type        = list(string)
  default     = []
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with the RDS instance"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Additional tags to apply to all resources in the module"
  type        = map(string)
  default     = {}
}
