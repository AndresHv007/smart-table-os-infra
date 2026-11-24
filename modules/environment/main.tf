terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

variable "env_name" {
  type = string
}

variable "app_env_value" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "name_suffix" {
  type = string
}

variable "sku_name" {
  type = string
}

variable "backend_image_name" {
  type = string
}

variable "frontend_image_name" {
  type = string
}

variable "sentry_dsn" {
  type      = string
  sensitive = true
}

locals {
  backend_app_name  = "smarttable-api-${var.env_name}-${var.name_suffix}"
  frontend_app_name = "smarttable-web-${var.env_name}-${var.name_suffix}"
  common_tags = {
    project     = "smart-table-os"
    environment = var.env_name
    managed_by  = "terraform"
  }
}

resource "azurerm_service_plan" "this" {
  name                = "asp-smarttable-${var.env_name}-${var.name_suffix}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.sku_name
  tags                = local.common_tags
}

resource "azurerm_linux_web_app" "backend" {
  name                = local.backend_app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id
  https_only          = true
  tags                = local.common_tags

  site_config {
    always_on                         = true
    websockets_enabled                = true
    health_check_path                 = "/health"
    health_check_eviction_time_in_min = 5

    application_stack {
      docker_image_name   = var.backend_image_name
      docker_registry_url = "https://index.docker.io"
    }
  }

  app_settings = {
    PORT                                = "3001"
    WEBSITES_PORT                       = "3001"
    APP_ENV                             = var.app_env_value
    APP_VERSION                         = "1.0.0"
    CORS_ORIGIN                         = "*"
    SENTRY_DSN                          = var.sentry_dsn
    DOCKER_ENABLE_CI                    = "false"
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
  }
}

resource "azurerm_linux_web_app" "frontend" {
  name                = local.frontend_app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id
  https_only          = true
  tags                = local.common_tags

  site_config {
    always_on                         = true
    health_check_path                 = "/health"
    health_check_eviction_time_in_min = 5

    application_stack {
      docker_image_name   = var.frontend_image_name
      docker_registry_url = "https://index.docker.io"
    }
  }

  app_settings = {
    WEBSITES_PORT                       = "80"
    API_URL                             = "https://${azurerm_linux_web_app.backend.default_hostname}"
    APP_ENV                             = var.app_env_value
    APP_VERSION                         = "1.0.0"
    DOCKER_ENABLE_CI                    = "false"
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
  }
}

output "service_plan_name" {
  value = azurerm_service_plan.this.name
}

output "backend_url" {
  value = "https://${azurerm_linux_web_app.backend.default_hostname}"
}

output "frontend_url" {
  value = "https://${azurerm_linux_web_app.frontend.default_hostname}"
}
