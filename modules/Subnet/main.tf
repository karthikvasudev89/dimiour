resource "azurerm_subnet" "this" {
  name = "snet-${var.subnet_name}"
  resource_group_name = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes = var.subnet_address_prefix
  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
}
output "subnet_id" {
  value = azurerm_subnet.this.id
}