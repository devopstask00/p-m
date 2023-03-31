variable "resource_group_name" {}
variable "subnet_id" {}

resource "azurerm_public_ip" "this" {
  name                = "myPublicIP"
  location            = "West US"
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "this" {
  name                = "myLoadBalancer"
  location            = "West  US"
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "myFrontEnd"
    public_ip_address_id = azurerm_public_ip.this.id
  }
}

resource "azurerm_lb_backend_address_pool" "this" {
  name            = "myBackEnd"
  loadbalancer_id = azurerm_lb.this.id
}

resource "azurerm_lb_probe" "this" {
  name                = "myProbe"
  loadbalancer_id     = azurerm_lb.this.id
  port                = 80
  protocol            = "Http"
  request_path        = "/"
  interval_in_seconds = 15
  number_of_probes    = 4
}

resource "azurerm_lb_rule" "this" {
  name                           = "myRule"
  loadbalancer_id                = azurerm_lb.this.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "myFrontEnd"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this.id]
  probe_id                       = azurerm_lb_probe.this.id
}

output "public_ip" {
  value = azurerm_public_ip.this.ip_address
}

