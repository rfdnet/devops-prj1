//criar namespace da monitoração

//Local Backend
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}



resource "null_resource" "monit" {

  provisioner "local-exec" {
    command = <<EOT
      kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
      helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
      helm repo update
      helm install monit prometheus-community/kube-prometheus-stack
      kubectl create ns monit
      cd ../monit   ; helm upgrade --install monit prometheus-community/kube-prometheus-stack --namespace monit -f values.yaml
      kubectl top pod --namespace monit 
      kubectl get secret --namespace monit monit-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
    EOT

  }
}