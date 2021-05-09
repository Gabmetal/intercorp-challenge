variable "prefix" {
    type        = string
    description = "Prefijo para nombre de recursos"
}

variable "resource_group_name" {
    type = string
    description = "Nombre del RG para desplegar el cluster"
}

variable "resource_group_location" {
    type = string
    description = "Location del RG"
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
    default = "VirtualMachineScaleSets"
}

variable "tags" {
    type = "map"
    description = "Tags para los recursos"
}