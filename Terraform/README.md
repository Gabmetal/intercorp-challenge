# Terraform module
## Despliegue del cluster AKS y Jenkins
Este modulo de terraform despliega un cluster de kubernetes en Azure e instala el chart de jenkins en él.

Para lograr esto es necesario rellenar el archivo `terraform.tfvars` con los valores necesarios para la conexión a Azure.
```
subscription_id = 
serviceprincipal_id = 
serviceprincipal_key = 
tenant_id = 
```
Parados en la carpeta root donde se encuentra el `main.tf` ejecutar el comando:
`terraform init`
para cargar y configurar los módulos y luego
`terraform apply --auto-approve`
para empezar a desplegar los recursos.

Cabe aclarar que en este caso el tfstate no se esta guardando en forma remota, sino que, en el equipo en el que se está ejecutando. Para guardar el estado en un storage account es necesario realizar lo siguiente:

1- Configurar variables de entorno:
```bash
# Location para el resoruce group
export location="eastus2"
# Nombre del resource Group
export sarg="tfstaterg"
# Nombre del storage account
export saname="tfstatestgacc"
# Nombre del container dentro del storage account que contendrá el tfstate
export contname="tfstatecontainer"
```
2- Crear el storage account en azure:
```bash
az group create -l $(location) --name $(sarg)
az storage account create --name $(saname) -g $(sarg) -l $(location) --sku "Standard_LRS" 
az storage container create -n $(contname) --account-name $(saname)
```
3- Agregar el backend a la configuración de terraform en el archivo `providers.tf` reemplazando los tokens (valores entre #{}# por los declarados en las variables)
```
terraform {
  required_providers {
    ...
    }
  backend  "azurerm" {
    resource_group_name  = "#{sarg}#"
    storage_account_name = "#{saname}#"
    container_name       = "#{contname}#"
    key                  = "terraform.tfstate"
    access_key           = "#{sakey}#"
  }
}
```
# Ingresando al cluster y a jenkins
Para ingresar al cluster deberemos conectarnos a azure desde la cli:
`az login`
Seleccionamos la subscription en donde desplegamos el cluster, para esto podemos listar las subs con el comando 
`az account list -o table` 
y de no figurarnos como true en la columna `IsDefault` podemos setearla con el comando 
`az account set -s <ID_DE_LA_SUB>`
Luego podemos listar los clusteres en esa sub con el comando 
`az aks list -o table`
y obtener las credenciales con
`az aks get-credentials -n <NombreDelCluster> -g <ResourceGroupDelCluster>`
Y finalmente para ver todos los recursos que están corriendo en el cluster ejecutamos:
`kubectl get all -A`
en este caso podremos ver el service de jenkins corriendo en el namespace `default` y su ip pública.
Por ejemplo:
```
NAMESPACE     NAME                     TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)                      AGE
default       service/jenkins          LoadBalancer   10.0.128.15    20.75.69.7    80:32465/TCP,443:31719/TCP   11m
```
ahora podemos ir al browser y tipear la EXTERNAL-IP para acceder a jenkins utilizando el usuario y contraseña que declaramos en el archivo `terraform.tfvars`