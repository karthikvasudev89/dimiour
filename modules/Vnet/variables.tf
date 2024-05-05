variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
  default = ["10.105.0.0/26"]
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
