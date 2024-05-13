locals {
  selector_labels = {
    "app.kubernetes.io/name"     = "web-app"
    "app.kubernetes.io/instance" = "master"
    "app.kubernetes.io/part-of"  = lookup(var.labels, "app.kubernetes.io/part-of", var.object_prefix)
  }

  common_labels = merge(var.labels, local.selector_labels, {
    "app.kubernetes.io/managed-by" = "terraform"
    "app.kubernetes.io/component"  = "web-app"
    }
  )

  env_config = format("{\"SQL_URI\":\"postgresql+psycopg2://%s:%s@%s:%d/%s}", var.username, var.password, var.db_host, var.db_port, var.db_name)
}

resource "kubernetes_deployment" "web-app" {
  metadata {
    name = "webapp"
    labels = local.common_labels
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = local.selector_labels
    }

    template {
      metadata {
        labels = local.selector_labels
      }
      
      spec {
        container {
          image = format("%s:%s", var.image_name, var.image_tag)
          name  = regex("[[:alnum:]]+$", var.image_name)
          image_pull_policy = "Always"

          port {
            container_port = var.container_port
          }

          env {
            name  = "ENV_CONFIG"
            value = local.env_config
          }

        }

      }
    }
  }
}