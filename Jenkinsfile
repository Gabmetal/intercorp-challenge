parameters{
    string(name: 'sp_appid', defaultValue: '', description: 'Azure Service Principal ID')
    string(name: 'sp_apppwd', defaultValue: '', description: 'Azure Service Principal password')
    string(name: 'sp_tenantid', defaultValue: '', description: 'Azure Service Principal tenant ID')
    string(name: 'sp_subscriptionid', defaultValue: '', description: 'Azure Service Principal subscription ID')
    string(name: 'aks_name', defaultValue: '', description: 'Cluster name')
    string(name: 'rg_name', defaultValue: '', description: 'Resource group name')
    choice(
        choices: ['./kubernetes_yamls/java.yaml','./kubernetes_yamls/nodejs.yaml'],
        description: 'Select yaml to deploy',
        name: 'SELECTED_YAML'
    )
}
podTemplate(containers: [
    containerTemplate(name: 'azcli', image: 'mcr.microsoft.com/azure-cli', ttyEnabled: true, command: 'cat')
]){
    node(POD_LABEL) {
        git https://github.com/Gabmetal/intercorp-challenge.git
        container('azcli') {
            stage('Login in Azure and get kubernetes credentials') {
                    sh '''
                    az login --service-principal --username $sp_appid --password $sp_apppwd --tenant $sp_tenantid
                    az account set -s $sp_subscriptionid
                    az aks get-credentials -n $aks_name -g $rg_name
                    az aks install-cli
                    kubectl apply -f $SELECTED_YAML
                    '''
            }
        }
    }
}
