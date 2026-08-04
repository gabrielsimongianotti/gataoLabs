variable "function_name" {
  type = string
}

variable "user_microservise_name" {
  type = string
}

variable "dynamodb_table_name" {
  type = string
}

variable "environment" {
  type    = string
  default = "staging"
}
