variable "app_service_name" {
  type = string
  default = "app-service-dev-01"
}
variable "resource_group_name" {
  type = string
  default = "rg-app-service-un-p-01"
}
variable "location" {
  type = string
}
variable "vnet_name" {
  type = string
  default = "vnet-dev-01"
}
variable "subnet_name" {
  type = string
  default = "subnet-dev-01"
}
variable "vnet_address_space" {
  type = list(string)
  default = ["10.0.0.0/16"]
}
variable "subnet_address_prefix" {
  type = list(string)
  default = ["10.0.0.0/24"]
}

variable "service_plan_name" {
  type = string
  default = "service-plan-dev-01"
}
variable "slot_count" {
  type = number
  default = 1
  description = "The number of app services slots to create"
}
variable "slot_name" {
  type = string
  default = "slot-dev-01"
}
variable "os_type" {
  type = string
  default = "Linux"
}
variable "sku_name" {
  type = string
  default = "P1v2"
  validation {
        error_message = "Please use a valid AppService SKU."
        condition = can(regex(join("", concat(["^("], [join("|", [ 
            "B1", "B2", "B3", "D1", "F1", 
            "FREE", "I1", "I1v2", "I2", "I2v2", 
            "I3", "I3v2", "P1v2", "P1v3", "P2v2", 
            "P2v3", "P3v2", "P3v3", "PC2", 
            "PC3", "PC4", "S1", "S2", "S3", 
            "SHARED", "WS1", "WS2", "WS3"
        ])], [")$"])), var.sku_name))
    }
}

