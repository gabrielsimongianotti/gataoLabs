terraform {
  required_version = "~> 1.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.7"
    }

    null = {
      source  = "hashicorp/null" # 👈 necessário para null_resource
      version = "~> 3.0"
    }

  }
}
module "lambda" {
  source = "./modules/lambda-template"

  function_name = var.function_name
  environment   = var.environment
}

module "user-microservise" {
  source = "./modules/user-microservise"

  function_name = var.user_microservise_name
  environment   = var.environment
}
