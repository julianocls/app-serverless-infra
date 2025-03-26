locals {
  common_tags = {
    Project   = "Auto Scaling App"
    CreatedAt = "2025-03-26"
    ManagedBy = "Terraform"
    Owner     = "Juliano Santos"
    Service   = var.service_name
  }
}
