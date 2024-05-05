resource "azurerm_service_plan" "this" {
  name                = "plan-${var.service_plan_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name
}
output "id" {
  value = azurerm_service_plan.this.id
}
