variable "resource_group_name" {
  type = string
  default = "rg-dev-01"
}

variable "location" {
  type = string
  default = "westeurope"
}
variable "tags" {
  type = map
  default = {
    "ownerName" = "karthik"
    "environment" = "dev"
    "businessUnit" = "UAE"
    "costCenter" = "it"
    "applicationName" = "app-service"
  }
}

