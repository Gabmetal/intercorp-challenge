English Version: https://github.com/Gabmetal/intercorp-challenge/blob/main/README.md
# intercorp-challenge

## Estructura de carpetas:
### root:
En el root del repositorio se encontrará el archivo `Jenkinsfile` el cual deberá ser utilizado por el pipeline de jenkins para desplegar los recursos en kubernetes.
También se encontrarán las siguientes carpetas:
### kubernetes_yamls
En esta carpeta estan los dos yamls para desplegar las aplicaciones en java y nodejs con sus respectivos hpa, services e ingress.
### Terraform
En esta carpeta se encuentran los módulos de terraform para desplegar el cluster, jenkins y nginx como ingress.

# Configuracion de jenkins para correr pipelines.
1- Ingresar a jenkins:
Para ingresar a jenkins necesitaremos conocer la ip del servicio desplegado en kubernetes, para esto debemos ejecutar el comando `kubectl get svc -n jenkins` y copiar la EXTERNAL-IP.
Utilizar el usuario y contraseña definido en el archivo `terraform.tfvars`

2- ingresar al menu "administrar jenkins" y actualizarlo si es necesario (A Jenkins y sus plugins)

3- instalar plugin de kubernetes (documentación https://github.com/jenkinsci/kubernetes-plugin)

4- configurar kubernetes como cloud:
   Para esto deberemos ingresar a adminsitrar jenkins -> Configure System -> Cloud -> Add new -> select 'Kubernetes'
   e ingresar los datos solicitados, en este caso solo es necesario cargar la url del api server y la ip interna de jenkins.

5- Agregar el puerto 38489 a la configuración de jenkins
   Panel de Control -> Configuración global de la seguridad -> Agents

6- Agregar el puerto al service de kubernetes:
   kubectl edit service/jenkins -n jenkins
   y en la seccion de puertos agregar el siguiente elemento:
```
- name: jenkinsagent
  port: 38489
  targetPort: 38489
  protocol: TCP
```

7- Crear un nuevo job del tipo multibranch pipeline, seleccionar Jenkinsfile from SCM. Agregar la url del repositorio y los parámetros solicitados por el Jenkinsfile.

8- Ejecutar el pipeline en "Correr con parámetros"

9- Completar los parámetros y ejecutar.