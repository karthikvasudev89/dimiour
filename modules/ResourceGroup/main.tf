resource "azurerm_resource_group" "this" {
  name = "rg-${var.resource_group_name}"
  location = var.location
  tags = var.tags
}
output "resource_group_name" {
  value = azurerm_resource_group.this.name
}
output "location" {
  value = azurerm_resource_group.this.location
}