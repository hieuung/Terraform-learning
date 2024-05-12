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
  default     = "hieuung/bookstore"
}

variable "image_tag" {
  type        = string
  description = "Docker image tag to use"
  default     = "v7"
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

variable "db_host" {
  type        = string
  description = "Database host"
}

variable "db_port" {
  type        = number
  description = "Database port"
  default     = 5432
}

variable "container_port" {
  type        = number
  description = "Internal port for service"
  default     = 80
}

variable "service_port" {
  type        = number
  description = "External port for service"
  default     = 80
}

