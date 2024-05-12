output "hostname" {
  description = "Name of the kubernetes service"
  value       = kubernetes_service.db_loadbalancer.metadata[0].name
}

output "port" {
  description = "Port for the kubernetes service"
  value       = kubernetes_service.db_loadbalancer.spec[0].port[0].port
}