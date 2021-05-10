module "resource_group" {
  source                   = "./modules/resource_group"
  prefix                   = var.prefix
  resource_group_location  = var.resource_group_location
}

module "ssh_key" {
  source         = "./modules/ssh_key"
  public_ssh_key = var.ssh_key == "" ? "" : var.ssh_key
}

module "kubernetes_cluster" {
  source                   = "./modules/azure_kubernetes_service"
  prefix                   = var.prefix
  resource_group_name      = module.resource_group.output.name
  resource_group_location  = module.resource_group.output.location
  kubernetes_version       = var.kubernetes_version
  node_count               = var.node_count
  vm_size                  = var.vm_size
  vm_type                  = var.vm_type
  tags                     = var.tags
}

module "jenkins_helm_release" {
  source          = "./modules/helm_release"
  jenkinsUser     = var.jenkinsUser
  jenkinsPassword = var.jenkinsPassword
  depends_on = [
    module.kubernetes_cluster
  ]
}
