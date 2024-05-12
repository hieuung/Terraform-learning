# INFRASTRUCTURE AS CODE WITH TERRAFORM ON KUBERNETES

## Tech stack
- Docker
- Kubernates (minikube)
- Terraform
- Postgresql

## Set up Postgresql on K8s using Terraform

Declare postgres configuaration

```
module "postgresql" {
  object_prefix = "terraform"
  source        = "./postgresql"
  namespace     = "terraform-database"
  db_name = "postgres"
  username = "hieuung"
  password = "hieuung"
  labels        = {
    "app.kubernetes.io/part-of" = "terraform-database"
  }
}
```
Setting up
```sh 
terraform plan
terraform apply
```

Verify Deployment

```
kubectl get deployment -n terraform-database
```