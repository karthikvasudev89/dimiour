resource "azurerm_virtual_network" "this" {
  name = "vnet-${var.vnet_name}"
  location = var.location
  resource_group_name = var.resource_group_name
  address_space = var.vnet_address_space
}
output "vnet_name" {
  value = azurerm_virtual_network.this.name
}