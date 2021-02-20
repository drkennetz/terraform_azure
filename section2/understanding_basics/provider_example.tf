provider "azurerm" {
  subscription_id = "00000-0000-0000-0000-0000000000"
  tenant_id = "11111-1111-1111-1111-1111111111"
}

provider "azurerm" {
  alias = "tenant2"
  subscription = "00000-0000-0000-0000-0000000000"
  tenant_id = "22222-2222-2222-2222-2222222222"
}

resource "azure_virtual_machine" "myvm" {
  provider = azurerm.tenant2
  [...]
}

module "mymodule" {
  source = "./mymodule"
  providers = {
    azurerm = azurerm.tenant2
  }
}