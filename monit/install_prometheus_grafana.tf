//criar namespace da monitoração

//instalar o helm do grafana/prometheus
resource "null_resource" "jenkins" {
  depends_on = [module.ebs, null_resource.namespace]
  provisioner "local-exec" {
    command = <<EOT
      helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
      helm repo update
      helm install monit prometheus-community/kube-prometheus-stack
      kubectl create ns monit
      cd ../monit   ; helm upgrade --install monit prometheus-community/kube-prometheus-stack --namespace monit -f values.yaml
      kubectl get secret --namespace monit monit-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
    EOT
  }