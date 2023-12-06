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
      echo "1 - helm installation"
      kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
      helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
      helm repo update
      kubectl create ns monit
      echo "2 - helm chart install"
      helm install monit prometheus-community/kube-prometheus-stack -n monit
      echo "3 - now running upgrade"
      helm upgrade --install monit prometheus-community/kube-prometheus-stack --namespace monit -f values.yaml
      kubectl --namespace monit get pods -l "release=monit"
      kubectl get secret --namespace monit monit-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
      echo "4 - listing svc"
      kubectl get svc -n monit
      echo "5 - Admin password :"
      kubectl get secret --namespace monit monit-grafana -o jsonpath="{.data.admin-password}" | base64 --decode
      echo "6 - grafana access : User port-forward on local  OR create a ELB, eg: kubectl port-forward svc/monit-grafana 8080:80 -n monit"
    EOT

  }
}