# Dimiour assessment:
Develop a Terraform module to deploy an Azure App Service within a Virtual Network, ensuring the setup includes staging slots and adheres to best practices in code reusability and documentation.

## INTRODUCTION:
    This is a sample terraform project to create an app service in Azure and integrate with a Vnet. 
    The app service will be created with a number of deployment slots. The app service will be created in a specific region and the app service will be created in a specific resource group.
    The app service will be created with a specific sku and the app service will be created with a specific os type.
    The app service will be integrated with Vnet.
    These templates are made in such a way that it can be reused for multiple projects.

## Resources will be created:
  - Resource Group
  - Vnet
  - Subnet and delegation to serverFarm
  - App Service Plan
  - App Service
  - Deployment Slots

## Prerequisites:
  - Terraform installed
  - Azure CLI installed and configured
  - Azure subscription id
  - Azure account storage account name
  - Azure account storage account resource group name
  - Azure account storage account container name

## Variables:
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

## How to run the terraform module:

Once you have the prerequisites installed and have the variables set you can run the following commands to create the app service and its dependencies:

Before running the below commands , one must have set the Azure CLI and the subscription id.
```bash
az login
az account set --subscription-id <subscription-id> #This is the subscription id of subscription where the storage account is located
```
Before setting the variables block, one must set the terraform backend configuration in the `main.tf` file as this template will utilize Azure storage account as a backend statefile storage.

We can also parameterize the backend configuration in the `main.tf` file. But it should be done outside the terraform such that the terraform file is clean and easy to read.

For an example this can be done on Azure DevOps pipeline YAML parameters and pass these as a variables. This will be more dynamic like you can pass the subscription id, resource group name, storage account name, container name, statefile name etc for each projects.

But this template is now set to have the backend configuration in the `main.tf` file as absolute values.

```bash
backend "azurerm" {
        resource_group_name  = "<storage_account_resource_group>"
        storage_account_name = "<your-storage-account-name>"
        container_name       = "<container_name>"
        key                  = "<statefile_name>" #we can modify this to be more dynamic for other projects
    }
```
Now set the variables in the `variables.tf` file and run the following commands:
```bash
terraform init
terraform plan
terraform apply
```

## Explanation:

This project's directory structure is as follows:

```bash
.
├── main.tf
├── variables.tf
└── modules
    ├── AppService
    ├── AppServicePlan
    ├── ResourceGroup
    ├── Subnet
    └── Vnet
```
`modules` directory contains the modules for the app service and its dependencies.

AppService module is responsible for creating the app service.
AppServicePlan module is responsible for creating the app service plan.
ResourceGroup module is responsible for creating the resource group.
Subnet module is responsible for creating the subnet.
Vnet module is responsible for creating the vnet.

Naming conventions for the resources to be created:

This template will append the following prefixes to the name of the resources.
AppService: appservice-<app_service_name>
AppServicePlan: plan-<service_plan_name>
ResourceGroup: rg-<resource_group_name>
Subnet: snet-<subnet_name>
Vnet : vnet-<vnet_name>

All these modules are orchestrated in the `main.tf` file of AppService module.So when we run the terraform apply command, the ResourceGroup module will be executed first then AppService module will be executed next and then the other modules will be executed in the sequence.

Once the resources are created, one can access their app service by using the following URL:
```bash
https://appservice-<app_service_name>.azurewebsites.net
```
In this sample template , site config of deployment slot is created with Docker container of latest NGINX image.
```bash
 application_stack {
    docker_image_name = "nginx:latest"
    }
```
NOTE: We are pulling this docker image from public repo, one can also use the private repo by simply configuring the docker container repo details as follows:
```bash
application_stack {
    docker_image_name = "my-private-repo/my-private-image:latest"
    docker_registry_url = "https://my-private-repo.azurecr.io"
    docker_registry_username = "my-private-repo"
    docker_registry_password = "my-private-password"
    }
```

After successfull deployment, one should be able to see the NGINX welcome page by hitting the deployment slot URL.
```bash
https://appservice-<app_service_name>-stagging-<index>.azurewebsites.net
```

## Future iterations:

These modules can be deployed via any CI CD tools like Jenkins, Azure DevOps, Github Actions, etc. And can be parameterized to be used for multiple projects. As well as conditions can be applied to the modules to use exisiting Vnet and other dependencies.
