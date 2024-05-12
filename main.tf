locals {
  db_host = "10.102.224.1"
}

module "postgresql" {
  object_prefix = "postgres"
  source        = "./postgresql"
  namespace     = "terraform-app"
  db_name = "postgres"
  username = "hieuung"
  password = "hieuung"
  cluster_ip = local.db_host
  labels        = {
    "app.kubernetes.io/part-of" = "terraform-database"
  }
}

module "webapp" {
  object_prefix = "web-app"
  source        = "./webapp"
  namespace     = "terraform-app"
  db_name = "postgres"
  username = "hieuung"
  password = "hieuung"
  db_host = local.db_host
  labels        = {
    "app.kubernetes.io/part-of" = "terraform-web"
  }
}
