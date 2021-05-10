resource "helm_release" "jenkins" {
  name             = "jenkins"
  repository       = "https://marketplace.azurecr.io/helm/v1/repo"
  chart            = "jenkins"
  namespace        = "jenkins"
  create_namespace = true

  set {
    name  = "jenkinsUser"
    value = var.jenkinsUser
  }
  set {
    name  = "jenkinsPassword"
    value = var.jenkinsPassword
  }
}

resource "helm_release" "nginx" {
  name             = "nginx"
  repository       = "https://helm.nginx.com/stable"
  chart            = "nginx-ingress"
  namespace        = "ingress-basic"
  timeout          = "900"
  create_namespace = true

  values = [
    "${file("helm_values/nginx_values.yaml")}"
  ]

}