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
       access_key = "HxINDcpfzz20I9nJ6A6NwyfvFDlstbGhadX910NMWD7o52RA9B64vcCwKLT2SpuP7xj5S3PjShB6EUt6UcifZg=="
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