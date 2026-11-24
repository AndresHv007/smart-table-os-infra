variable "subscription_id" {
  description = "ID de la suscripcion de Azure (tambien puede pasarse via ARM_SUBSCRIPTION_ID)"
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "Nombre del Resource Group principal"
  type        = string
  default     = "rg-smarttable-os"
}

variable "location" {
  description = "Region de Azure donde se despliegan los recursos"
  type        = string
  default     = "mexicocentral"
}

variable "name_suffix" {
  description = "Sufijo unico global para nombres de App Services (*.azurewebsites.net)"
  type        = string
  default     = "andreshu"
}

variable "sku_name" {
  description = "SKU del App Service Plan Linux (B1 recomendado para contenedores + WebSockets + metricas)"
  type        = string
  default     = "B1"
}

variable "docker_hub_user" {
  description = "Usuario de Docker Hub donde viven las imagenes"
  type        = string
  default     = "andreshu07"
}

variable "backend_tag_dev" {
  description = "Tag inicial de Docker Hub para Backend Dev"
  type        = string
  default     = "latest"
}

variable "backend_tag_prod" {
  description = "Tag inicial de Docker Hub para Backend Prod"
  type        = string
  default     = "latest"
}

variable "frontend_tag_dev" {
  description = "Tag inicial de Docker Hub para Frontend Dev"
  type        = string
  default     = "latest"
}

variable "frontend_tag_prod" {
  description = "Tag inicial de Docker Hub para Frontend Prod"
  type        = string
  default     = "latest"
}

variable "sentry_dsn" {
  description = "DSN de Sentry para monitoreo APM (trazas, errores y mensajes)"
  type        = string
  sensitive   = true
  default     = ""
}
