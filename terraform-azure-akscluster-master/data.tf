## Required for advanced networking
data "azurerm_subnet" "aks-subnet" {
  name                 = var.aksSubnetName
  virtual_network_name = var.vnetName
  resource_group_name  = var.resourceGroup
}
