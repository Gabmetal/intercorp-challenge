terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.58.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.1.2"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.serviceprincipal_id
  client_secret   = var.serviceprincipal_key
  tenant_id       = var.tenant_id

  features {}
}

provider "helm" {
  kubernetes {
    host                   = module.kubernetes_cluster.output.kube_config.0.host
    client_certificate     = base64decode(module.kubernetes_cluster.output.kube_config.0.client_certificate)
    client_key             = base64decode(module.kubernetes_cluster.output.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(module.kubernetes_cluster.output.kube_config.0.cluster_ca_certificate)
  }
}