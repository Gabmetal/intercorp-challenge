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
    type = string
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
    type = "map"
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