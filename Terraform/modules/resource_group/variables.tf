variable "prefix" {
    type        = string
    description = "prefijo para el nombre del resource group donde se desplegaran los recursos"
}

variable "resource_group_location" {
    type        = string
    description = "Location donde deseamos desplegar los recursos"
}
