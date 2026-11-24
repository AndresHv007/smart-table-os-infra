# Smart Table OS — Infraestructura como Código (Terraform + Azure)

Proyecto modular de Terraform (`azurerm ~> 4.0`) que provisiona los ambientes **Dev** y **Prod** de **Smart Table OS** en Microsoft Azure.

## Recursos creados
- **Resource Group:** `rg-smarttable-os`
- **Ambiente Dev (`modules/environment`):**
  - App Service Plan Linux `B1` (`asp-smarttable-dev-andreshu`) — métricas de CPU y Memoria en Azure Portal
  - Web App Backend (`smarttable-api-dev-andreshu`) — contenedor `andreshu07/smarttable-api`, WebSockets habilitados, Sentry APM
  - Web App Frontend (`smarttable-web-dev-andreshu`) — contenedor `andreshu07/smarttable-web`, inyección de `API_URL` apuntando al backend Dev
- **Ambiente Prod (`modules/environment`):**
  - App Service Plan Linux `B1` (`asp-smarttable-prod-andreshu`)
  - Web App Backend (`smarttable-api-prod-andreshu`)
  - Web App Frontend (`smarttable-web-prod-andreshu`)

## Despliegue
```bash
cp terraform.tfvars.example terraform.tfvars
# Completar subscription_id y sentry_dsn
terraform init
terraform plan
terraform apply
```

## Destrucción de recursos (para evitar costos)
```bash
terraform destroy
```
