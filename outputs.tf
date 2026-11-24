output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "dev_backend_url" {
  value = module.dev.backend_url
}

output "dev_frontend_url" {
  value = module.dev.frontend_url
}

output "dev_service_plan_name" {
  value = module.dev.service_plan_name
}

output "prod_backend_url" {
  value = module.prod.backend_url
}

output "prod_frontend_url" {
  value = module.prod.frontend_url
}

output "prod_service_plan_name" {
  value = module.prod.service_plan_name
}
