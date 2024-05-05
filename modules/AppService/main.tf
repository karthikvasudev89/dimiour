module "vnet" {
  source = "../Vnet"
  resource_group_name = var.resource_group_name
  location = var.location
  vnet_name = var.vnet_name
  vnet_address_space = var.vnet_address_space
}
module "subnet" {
  source = "../Subnet"
  resource_group_name = var.resource_group_name
  vnet_name = module.vnet.vnet_name
  subnet_name = var.subnet_name
  subnet_address_prefix = var.subnet_address_prefix
}
module "appserviceplan" {
  source = "../AppServicePlan"
  resource_group_name = var.resource_group_name
  location = var.location
  service_plan_name = var.service_plan_name
  os_type = var.os_type
  sku_name = var.sku_name
}
resource "azurerm_linux_web_app" "this" {
  name                      = "appservice-${var.app_service_name}"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  service_plan_id       = module.appserviceplan.id
  app_settings = {
    "WEBSITES_CONTAINER_START_TIME_LIMIT" = "1200"
  }

  site_config {
    always_on  = true
  }
  virtual_network_subnet_id = module.subnet.subnet_id
}
resource "azurerm_linux_web_app_slot" "this" {
  count = var.slot_count
  name           = "${var.slot_name}-${count.index}"
  app_service_id = azurerm_linux_web_app.this.id

  site_config {
    application_stack {
    docker_image_name = "nginx:latest"
    }
  }
}

