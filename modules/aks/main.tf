variable "subnet_id" {}

resource "azurerm_kubernetes_cluster" "this" {
  name                = "myAKSCluster"
  location            = "West US"
  resource_group_name = "1-67d15b4a-playground-sandbox"
  dns_prefix          = "myaks"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }
}

output "kubeconfig" {
  value = azurerm_kubernetes_cluster.this.kube_config_raw
}

