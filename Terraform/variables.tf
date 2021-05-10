variable "tenant_id" {
    type = string
    description = "Valor del Tenant ID"
}

variable "subscription_id" {
    type = string
    description = "Valor de Subscription ID de azure"
}

variable "serviceprincipal_id" {
    type = string
    description = "Valor de serviceprincipal id azure"
}

variable "serviceprincipal_key" {
    type = string
    description = "Valor de serviceprincipal key azure"
}

variable "prefix" {
    type = string
    description = "Prefijo para nombre de recursos"
}

variable "resource_group_location" {
    type = string
    description = "Location del RG"
}

variable "ssh_key" {
    type = string
    description = "ssh key preexistente"
    default     = ""
}

variable "kubernetes_version" {
    type = string
    description = "Version de kubernetes a desplegar"
}

variable "node_count" {
    type = number
    description = "Cantidad de nodos en el pool"
}

variable "vm_size" {
    type = string
    description = "Tipo de vm para los nodos"
}

variable "vm_type" {
    type = string
    description = "Tipo de despliegue de las vm en el nodo (AvailabilitySet o VirtualMachineScaleSets)"
}

variable "tags" {
    type = map(string)
    description = "Tags para los recursos"
}

variable "jenkinsUser" {
    type = string
    description = "Usuario administrador de jenkins"
}
variable "jenkinsPassword" {
    type = string
    description = "Contraseña del usuario de jenkins"
}