resource "helm_release" "jenkins" {
  name       = "JenkinsK8S"
  repository = "https://marketplace.azurecr.io/helm/v1/repo"
  chart      = "jenkins"

  set {
    name  = "jenkinsUser"
    value = var.jenkinsUser
  }
  set {
    name  = "jenkinsPassword"
    value = var.jenkinsPassword
  }
}