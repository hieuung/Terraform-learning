variable "object_prefix" {
  type        = string
  description = "Unique name to prefix all objects with"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace for deployment"
}

variable "labels" {
  type        = map(string)
  description = "Labels to add"
  default     = {}
}

variable "image_name" {
  type        = string
  description = "Docker image to use"
  default     = "postgres"
}

variable "image_tag" {
  type        = string
  description = "Docker image tag to use"
  default     = "14"
}

variable "username" {
  type        = string
  description = "Database user name"
  default     = "hieuung"
}

variable "password" {
  type        = string
  description = "Database user password"
  default     = "hieuung"
}

variable "db_name" {
  type        = string
  description = "Database name"
  default     = "hieuung"
}

variable "container_port" {
  type        = number
  description = "Internal port for service"
  default     = 5432
}

variable "service_port" {
  type        = number
  description = "External port for service"
  default     = 5432
}

variable "cluster_ip" {
  type        = string
  description = "Cluster IP"
  default     = "10.102.224.1"
}

variable "loadbalancer_ip" {
  type        = string
  description = "Load balancer IP"
  default     = "10.102.224.2"
}


variable "resources_requests_cpu" {
  type        = string
  description = "The maximum amount of compute resources allowed"
  default     = null
}

variable "resources_requests_memory" {
  type        = string
  description = "The minimum amount of compute resources required"
  default     = null
}

variable "resources_limits_cpu" {
  type        = string
  description = "The maximum amount of compute resources allowed"
  default     = null
}

variable "resources_limits_memory" {
  type        = string
  description = "The minimum amount of compute resources required"
  default     = null
}


variable "volume_storage" {
  type        = string
  description = "The minimum amount of compute resources required"
  default     = "5Gi"
}