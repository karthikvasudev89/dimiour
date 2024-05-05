## Dimiour assessment:
Develop a Terraform module to deploy an Azure App Service within a Virtual Network, ensuring the setup includes staging slots and adheres to best practices in code reusability and documentation.

# INTRODUCTION:
    This is a sample terraform project to create an app service in Azure and integrate with a Vnet. 
    The app service will be created with a number of deployment slots. The app service will be created in a specific region and the app service will be created in a specific resource group.
    The app service will be created with a specific sku and the app service will be created with a specific os type.
    The app service will be integrated with Vnet.
    These templates are made in such a way that it can be reused for multiple projects.

# Resources will be created:
  - Resource Group
  - Vnet
  - Subnet and delegation to serverFarm
  - App Service Plan
  - App Service
  - Deployment Slots

# Prerequisites:
  - Terraform installed
  - Azure CLI installed and configured
  - Azure subscription id
  - Azure account storage account name
  - Azure account storage account resource group name
  - Azure account storage account container name

# Variables:
  - subscription_id - the subscription id of the subscription where the app service will be created
  - location - the location of the resources
  - resource_group_name - the resource group where the app service will be created
  - app_service_name - the name of the app service
  - service_plan_name - the plan of the app service
  - sku_name - the name of the sku
  - os_type - the os type of the app service
  - slot_name - the name of the deployment slot
  - slot_count - the number of deployment slots to be created
  - vnet_name - the name of the vnet where the app service will be created
  - vnet_address_space - the address space of the vnet 
  - subnet_name - the name of the subnet where the app service will be created
  - subnet_address_prefix - the address prefix of the subnet

Once you have the prerequisites installed and have the variables set you can run the following commands to create the app service and its dependencies:
```bash
terraform init
terraform plan
terraform apply
```
