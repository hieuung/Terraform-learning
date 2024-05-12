locals {
  selector_labels = {
    "app.kubernetes.io/name"     = "postgresql"
    "app.kubernetes.io/instance" = "master"
    "app.kubernetes.io/part-of"  = lookup(var.labels, "app.kubernetes.io/part-of", var.object_prefix)
  }

  common_labels = merge(var.labels, local.selector_labels, {
    "app.kubernetes.io/managed-by" = "terraform"
    "app.kubernetes.io/component"  = "postgresql"
    }
  )
}

resource "kubernetes_namespace" "db" {
  metadata {
    labels = local.common_labels
    name = var.namespace
  }
}

resource "kubernetes_deployment" "db" {
  metadata {
    name = "postgres"
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
          
          resources {
            limits = {
              cpu    = var.resources_limits_cpu
              memory = var.resources_limits_memory
            }
            requests = {
              cpu    = var.resources_requests_cpu
              memory = var.resources_requests_memory
            }
          }

          volume_mount {
            name = "postgres-volume"
            mount_path = "/var/lib/postgresql/"
          }

          port {
            container_port = var.container_port
          }

          env {
            name  = "POSTGRESQL_DATABASE"
            value = var.db_name
          }

          env {
            name  = "POSTGRESQL_USERNAME"
            value = var.username
          }

          env {
            name  = "POSTGRES_PASSWORD"
            value = var.password
          }

        }
        volume {
          name = "postgres-volume"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.db_volume_claim.metadata[0].name
          }
        }

      }
    }
  }
}

resource "kubernetes_persistent_volume" "db_volume" {
  metadata {
    name = "postgres-volume"
  }
  spec {
    capacity = {
      storage = var.volume_storage
    }
    access_modes = ["ReadWriteMany"]
    storage_class_name = "manual"
    persistent_volume_source {
      host_path {
        path = "/data/postgresql"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "db_volume_claim" {
  metadata {
    name = "postgres-volume-claim"
    namespace = var.namespace
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = var.volume_storage
      }
    }
    storage_class_name = "manual"
    volume_name = kubernetes_persistent_volume.db_volume.metadata[0].name
  }
}

resource "kubernetes_service" "db_sevrice" {
  metadata {
    name = "db-sevrice"
    namespace = var.namespace
  }
  spec {
    selector = local.selector_labels
    cluster_ip = var.cluster_ip
    port {
      port        = var.container_port
      target_port = var.container_port
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_service" "db_loadbalancer" {
  metadata {
    name = "db-loadbalancer"
    namespace = var.namespace
  }
  spec {
    selector = local.selector_labels
    cluster_ip = var.loadbalancer_ip
    port {
      port        = var.service_port
      target_port = var.container_port
    }
    type = "LoadBalancer"
  }
}
