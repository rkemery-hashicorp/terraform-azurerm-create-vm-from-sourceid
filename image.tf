resource "azurerm_image" "rkemery_winvm_azurerm_image" {
  name                      = var.azurerm_vm_image_name
  location                  = azurerm_resource_group.rkemery_winvm_rg.location
  resource_group_name       = azurerm_resource_group.rkemery_winvm_rg.name
  source_virtual_machine_id = azurerm_windows_virtual_machine.rkemery_winvm_image.id
}

resource "azurerm_public_ip" "rkemery_winvm_copy_public_ip" {
  name                = var.public_ip_copy_name
  location            = azurerm_resource_group.rkemery_winvm_rg.location
  resource_group_name = azurerm_resource_group.rkemery_winvm_rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "rkemery_winvmcopy_nic" {
  name                = var.nic_vmcopy_name
  location            = azurerm_resource_group.rkemery_winvm_rg.location
  resource_group_name = azurerm_resource_group.rkemery_winvm_rg.name

  ip_configuration {
    name                          = var.ip_vmcopy_name
    subnet_id                     = azurerm_subnet.rkemery_winvm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.rkemery_winvm_copy_public_ip.id
  }
}

resource "azurerm_windows_virtual_machine" "rkemery_winvm_copy" {
  name                  = var.winvm_copy_name
  location              = azurerm_resource_group.rkemery_winvm_rg.location
  size                  = "Standard_F2"
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  resource_group_name   = azurerm_resource_group.rkemery_winvm_rg.name
  network_interface_ids = [
    azurerm_network_interface.rkemery_winvmcopy_nic.id,
  ]

  source_image_id = azurerm_image.rkemery_winvm_azurerm_image.id

  depends_on = [azurerm_image.rkemery_winvm_azurerm_image]

  os_disk {
    name = var.winvm_copy_disk_name
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
 }
}
