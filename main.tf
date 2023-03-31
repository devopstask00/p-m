provider "azurerm" {
  features {}
  skip_provider_registration = true

   
}

module "network" {
  source = "./modules/network"
}

module "aks" {
  source = "./modules/aks"

  subnet_id = module.network.subnet_id
}

module "load_balancer" {
  source = "./modules/load_balancer"

  resource_group_name = module.network.resource_group_name
  subnet_id           = module.network.subnet_id
}

output "kubeconfig" {
  value = module.aks.kubeconfig
  sensitive = true
}
