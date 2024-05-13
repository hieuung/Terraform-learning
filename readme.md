# INFRASTRUCTURE AS CODE WITH TERRAFORM ON KUBERNETES

## Tech stack
- Docker
- Kubernates (minikube)
- Terraform
- Postgresql

## Set up Application on K8s using Terraform

Setting up
```sh 
terraform plan
terraform apply
```

Verify Deployment

```
kubectl get deployment -n terraform-database
```