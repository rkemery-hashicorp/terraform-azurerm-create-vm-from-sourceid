provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rkemery_winvm_rg" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_virtual_network" "rkemery_winvm_vnet" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rkemery_winvm_rg.location
  resource_group_name = azurerm_resource_group.rkemery_winvm_rg.name
}

resource "azurerm_subnet" "rkemery_winvm_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rkemery_winvm_rg.name
  virtual_network_name = azurerm_virtual_network.rkemery_winvm_vnet.name
  address_prefixes      = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "rkemery_winvm_public_ip" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.rkemery_winvm_rg.location
  resource_group_name = azurerm_resource_group.rkemery_winvm_rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "rkemery_winvm_nic" {
  name                = var.nic_name
  location            = azurerm_resource_group.rkemery_winvm_rg.location
  resource_group_name = azurerm_resource_group.rkemery_winvm_rg.name

  ip_configuration {
    name                          = var.ip_name
    subnet_id                     = azurerm_subnet.rkemery_winvm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.rkemery_winvm_public_ip.id
  }
}

resource "azurerm_windows_virtual_machine" "rkemery_winvm_image" {
  name                = var.winvm_image_name
  resource_group_name = azurerm_resource_group.rkemery_winvm_rg.name
  location            = azurerm_resource_group.rkemery_winvm_rg.location
  size                = "Standard_F2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.rkemery_winvm_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.winvm_publisher
    offer     = var.winvm_offer
    sku       = var.winvm_sku
    version   = var.winvm_version
  }
}

output "public_ip_address" {
  value = azurerm_public_ip.rkemery_winvm_public_ip.ip_address
}
