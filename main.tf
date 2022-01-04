provider "azurerm"{

    features {
      
    }
}

terraform {
  backend "azurerm" {
       resource_group_name = "tf_rg_blobstore"
       storage_account_name = "tfstorageaccountbaymak"
       container_name = "tfstate"
       key = "terraform.tfstate"
  }
 
}

resource "azurerm_resource_group" "tf_test" {
    name = "tfmainrg"
    location = "West Europe"
  
}

resource "azurerm_container_group" "tfcg_test" {
    name = "baymakweatherapi"
    location = azurerm_resource_group.tf_test.location
    resource_group_name = azurerm_resource_group.tf_test.name

    ip_address_type = "public"
    dns_name_label = "baymakweatherapitf"
    os_type = "Linux"

    container {
      name = "baymakweatherapi"
      image = "baymak/baymakweatherapi"
      cpu = "1"
      memory = "1"

      ports{
          port = "80"
          protocol = "TCP"
      }
    }
  
}