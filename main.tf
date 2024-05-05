terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "3.102.0"
        }
    }
    backend "azurerm" {
        resource_group_name  = "<storage_account_resource_group>"
        storage_account_name = "<your-storage-account-name>"
        container_name       = "<container_name>"
        key                  = "<statefile_name>" #we can modify this to be more dynamic for other projects
    }
}
provider "azurerm" {
    features {}
    subscription_id = var.subscription_id  #this is the subscription id of the subscription where the resources will be created
}
module "rg" {
    source = "./modules/ResourceGroup"
    resource_group_name = var.resource_group_name
    location = var.location
}
module "appservice" {
    source = "./modules/AppService"
    resource_group_name = var.resource_group_name
    location = var.location
    vnet_name = var.vnet_name
    vnet_address_space = var.vnet_address_space
    subnet_name = var.subnet_name
    subnet_address_prefix = var.subnet_address_prefix
    service_plan_name = var.service_plan_name
    os_type = var.os_type
    sku_name = var.sku_name
    app_service_name = var.app_service_name
    slot_count = var.slot_count
}





