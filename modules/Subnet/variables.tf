variable "subnet_address_prefix" {
  type = list(string)
  default = ["10.105.0.0/28"]
}
variable "subnet_name" {
  type = string
}
variable "vnet_name" {
  type = string
}
variable "resource_group_name" {
  type = string
}

