resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  dns_prefix          = "${var.prefix}-aks"
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name             = "default"
    node_count       = var.node_count
    vm_size          = var.vm_size
    type             = var.vm_type
  }

  identity {
    type  = "SystemAssigned"
  }

  tags = var.tags
}