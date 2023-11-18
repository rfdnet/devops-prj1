# devops-prj1

This is my test / base project with APP + Infra + Github Action (pipeline) 


Part 1 - Terraform infra 
All terraform scripts are saved with /infra. Also you need to deploy cluster-autoscaler.yml (see app/cluster-autoscaler)

1. Download the code
2. terraform the code in order to install EKS cluster [demo]
3. once EKS cluster is created and avaiable , use aws eks command for the authentication 
Eg : aws eks --region us-west-2 update-kubeconfig --name demo



Part 2 - Application
This is a hello world application using nginx image and a simple static content (see app/static-content)

Part 3 - CI/CD with github actions
GITHUB Actions solution to push latest changes on Kubernetes cluster.
