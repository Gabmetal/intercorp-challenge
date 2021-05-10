Versión en español: https://github.com/Gabmetal/intercorp-challenge/blob/main/Terraform/README_ES.md
## Terraform module
## AKS and Jenkins cluster deployment
This terraform module deploys a kubernetes cluster to Azure and installs the jenkins chart on it.

To accomplish this you need to populate the `terraform.tfvars` file with the values needed for the Azure connection.

```
subscription_id = 
serviceprincipal_id = 
serviceprincipal_key = 
tenant_id = 
```

Standing in the root folder where the `main.tf` is located run the command:
`terraform init`
to load and configure the modules and then
`terraform apply --auto-approve` to start deploying the resources.
to start deploying the resources.

It should be noted that in this case the tfstate is not being saved remotely, but on the computer where it is running. To save the state in a storage account it is necessary to do the following:

1- Configure environment variables:

```bash
# Location for the resoruce group
export location="eastus2"
# Name of the resource Group
export sarg="tfstaterg"
# Name of the storage account
export saname="tfstatestgacc" # Name of the container inside the storage account that will contain the tfstatestgacc
# Name of the container inside the storage account that will contain the tfstate
export contname="tfstatecontainer" # Name of the container inside the storage account that will contain the tfstate
```

2- Create the storage account in azure:

```bash
az group create -l $(location) --name $(sarg)
az storage account create --name $(saname) -g $(sarg) -l $(location) --sku "Standard_LRS" 
az storage container create -n $(contname) --account-name $(saname)
```

3- Add the backend to the terraform configuration in the `providers.tf` file replacing the tokens (values between #{}# by the ones declared in the variables)

```
terraform {
  required_providers {
    ...
    }
  backend "azurerm" {
    resource_group_name = "#{sarg}#"
    storage_account_name = "#{saname}#"
    container_name = "#{contname}#"
    key = "terraform.tfstate"
    access_key = "#{sakey}#"
  }
}
```

# Logging into the cluster and jenkins
To login to the cluster we will have to connect to azure from the cli:
`az login`

We select the subscription where we deploy the cluster, for this we can list the subs with the command 
`az account list -o table` 

and if the `IsDefault` column is not set to true, we can set it with the command 
`az account set -s <ID_DE_LA_SUB>` command.

Then we can list the clusters in that sub with the command 
`az aks list -o table`

and get the credentials with
`az aks get-credentials -n <ClusterName> -g <ClusterResourceGroup>``.

And finally to see all the resources that are running in the cluster we execute:
`kubectl get all -A`

in this case we will be able to see the jenkins service running in the `default` namespace and its public ip.

For example:

```
NAMESPACE NAME TYPE CLUSTER-IP EXTERNAL-IP PORT(S) AGE
default service/jenkins LoadBalancer 10.0.128.15 20.75.69.7 80:32465/TCP,443:31719/TCP 11m
```

now we can go to the browser and type the EXTERNAL-IP to access jenkins using the username and password we declared in the `terraform.tfvars` file.
