locals {
  lambdas_path = "${path.module}/../app/lambdas"
  layers_path  = "${path.module}/../app/layers/nodejs"
  layer_name   = "joi.zip"

  common_tags = {
    Project   = "TODO Serverless App"
    CreatedAt = "2025-01-07"
    ManagedBy = "Terraform"
    Owner     = "Juliano Santos"
    Service   = var.service_name
  }
}
