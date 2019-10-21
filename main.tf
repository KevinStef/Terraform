resource "azurerm_resource_group" "resource_group_kevin" {
  name          ="libros1"
  location      ="West Europe"
}
resource "azurerm_mysql_server" "mysql_server_kevin" {
  name="lider-tecnico1"
  location=azurerm_resource_group.resource_group_kevin.location
  resource_group_name=azurerm_resource_group.resource_group_kevin.name

 sku {
    name     = "B_Gen5_2"
    capacity = 2
    tier     = "Basic"
    family   = "Gen5"
  }

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = "mysqladminun"
  administrator_login_password = "H@Sh1CoR3!"
  version                      = "5.7"
  ssl_enforcement              = "Enabled"
}
resource "azurerm_cognitive_account" "computer_vision_service" {
   name="RecoFacial"
  resource_group_name=azurerm_resource_group.resource_group_kevin.name
  location=azurerm_resource_group.resource_group_kevin.location
  kind="ComputerVision"
   sku {
      name="F0"
      tier="Free"
  }
}
output "computer_vision_endpoint" {
    value=azurerm_cognitive_account.computer_vision_service.endpoint
}

resource "azurerm_app_service_plan" "app_service_kevin" {
  name              =   "RecoFacial_serviceplan"
  location          =   azurerm_resource_group.resource_group_kevin.location
  resource_group_name=  azurerm_resource_group.resource_group_kevin.name
  sku{
      tier="Free"
      size="F1"
  }
}

resource "azurerm_app_service" "app_service_terraform" {
  name=         "Recofacial-terraform"
  location=     azurerm_resource_group.resource_group_kevin.location
  resource_group_name= azurerm_resource_group.resource_group_kevin.name
  app_service_plan_id=azurerm_app_service_plan.app_service_kevin.id
  app_settings={
      "ejemplo1"="wwww.kevinsaldana.es",
      "ejemplo2"="otra key"
  }
}




