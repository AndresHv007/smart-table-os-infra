resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    project    = "smart-table-os"
    managed_by = "terraform"
    course     = "desarrollo-continuo"
  }
}

module "dev" {
  source = "./modules/environment"

  env_name            = "dev"
  app_env_value       = "development"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name_suffix         = var.name_suffix
  sku_name            = var.sku_name
  backend_image_name  = "${var.docker_hub_user}/smarttable-api:${var.backend_tag_dev}"
  frontend_image_name = "${var.docker_hub_user}/smarttable-web:${var.frontend_tag_dev}"
  sentry_dsn          = var.sentry_dsn
}

module "prod" {
  source = "./modules/environment"

  env_name            = "prod"
  app_env_value       = "production"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name_suffix         = var.name_suffix
  sku_name            = var.sku_name
  backend_image_name  = "${var.docker_hub_user}/smarttable-api:${var.backend_tag_prod}"
  frontend_image_name = "${var.docker_hub_user}/smarttable-web:${var.frontend_tag_prod}"
  sentry_dsn          = var.sentry_dsn
}
