variable "rg_name" {
default = "rkemery_winvm_rg"
}

variable "location" {
default = "eastus"
}

variable "vnet_name" {
default = "rkemery_winvm_vnet"
}

variable "subnet_name" {
default = "rkemery_winvm_subnet"
}

variable "nic_name" {
default = "rkemery_winvm_nic"
}

variable "ip_name" {
default = "rkemery_winvm_ip"
}

variable "public_ip_name" {
default = "rkemery_winvm_public_ip"
}

variable "winvm_image_name" {
default = "rkemerywin2016"
}

variable "admin_username" {
default = ""
}

variable "admin_password" {
default = ""
}

variable "winvm_publisher" {
default = "MicrosoftWindowsServer"
}

variable "winvm_offer" {
default = "WindowsServer"
}

variable "winvm_sku" {
default = "2016-Datacenter"
}

variable "winvm_version" {
default = "latest"
}

variable "azurerm_image_name" {
default = "rkemery_azurerm_image"
}

variable "winvm_copy_name" {
default = "rkemerywin16cpy"
}

variable "azurerm_vm_image_name" {
default = "rkemery_winvm_golden_image_server2016"
}

variable "winvm_copy_disk_name" {
default = "rkemery_winvm_copy_disk"
}

variable "nic_vmcopy_name" {
default = "rkemery_winvm_nic_copy"
}

variable "ip_vmcopy_name" {
default = "rkemery_ip_vmcopy"
}

variable "public_ip_copy_name" {
default = "rkemery_public_ip_copy"
}
