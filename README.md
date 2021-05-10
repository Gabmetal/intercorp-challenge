Versión en español: https://github.com/Gabmetal/intercorp-challenge/blob/main/README_ES.md
## intercorp-challenge

## Folder structure:
### root:
In the repository root you will find the `Jenkinsfile` file which should be used by the jenkins pipeline to deploy resources to kubernetes.
You will also find the following folders:
### kubernetes_yamls
In this folder are the two yamls to deploy the java and nodejs applications with their respective hpa, services and ingress.
### Terraform
In this folder are the terraform modules to deploy the cluster, jenkins and nginx as ingress.

# Configuration of jenkins to run pipelines.
1- Login to jenkins:
To login to jenkins we will need to know the ip of the service deployed in kubernetes, for this we must execute the command `kubectl get svc -n jenkins` and copy the EXTERNAL-IP.
Use the user and password defined in the `terraform.tfvars` file.

2- enter the menu "manage jenkins" and update it if necessary (To Jenkins and it's plugins)

3- install kubernetes plugin (documentation https://github.com/jenkinsci/kubernetes-plugin)

4- configure kubernetes as cloud:
   For this we will have to enter adminsitrar jenkins -> Configure System -> Cloud -> Add new -> select 'Kubernetes' and enter the requested data.
   and enter the requested data, in this case it is only necessary to load the url of the api server and the internal ip of jenkins.

5- Add port 38489 to the jenkins configuration
   Control Panel -> Global security configuration -> Agents

6- Add the port to the kubernetes service:
   kubectl edit service/jenkins -n jenkins
   and in the ports section add the following item:
```
- name: jenkinsagent
  port: 38489
  targetPort: 38489
  protocol: TCP
```

7- Create a new job of type multibranch pipeline, select Jenkinsfile from SCM. Add the url of the repository and the parameters requested by the Jenkinsfile.

8- Execute the pipeline in "Run with parameters".

9- Complete the parameters and execute.

Translated with www.DeepL.com/Translator (free version)