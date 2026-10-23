locals {
  tags = {
    Project     = var.name
    Environment = var.env
    ManagedBy   = "terraform"
  }
}
