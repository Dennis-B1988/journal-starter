name = "journal-staging"
env  = "staging"

region = "us-east-1"

cidr = "10.10.0.0/16"

azs = ["us-east-1a", "us-east-1b"]

public_subnets  = ["10.10.1.0/24", "10.10.2.0/24"]
private_subnets = ["10.10.3.0/24", "10.10.4.0/24"]

instance_type  = "t3.micro"
instance_count = 1

db_engine                  = "postgres"
db_engine_version          = "15.19"
db_instance_class          = "db.t3.micro"
db_allocated_storage       = 20
db_backup_retention_period = 7
db_skip_final_snapshot     = true

db_username = "postgres"
db_password = "postgres"