locals {
  lambdas_path = "app/lambdas"
  layers_path  = "app/layers/nodejs"
  layer_name   = "joi.zip"

  common_tags = {
    Project   = "TODO Serverless App"
    CreatedAt = "2025-01-07"
    ManagedBy = "Terraform"
    Owner     = "Juliano Santos"
    Service   = var.service_name
  }
}
