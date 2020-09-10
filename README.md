# terraform-azurerm-create-vm-from-sourceid

## Purpose

Create a golden image VM, apply desired config, generalize VM - then use that VM to create a source image and apply that image to a new VM.

* Main.tf creates the golden image VM
* Once that is finished, the VM needs to be sysprep /generalize and then also completely powered off in Azure.
* az vm generalize --resource-group <ResourceGroupName> --name <SourceVirtualMachineName>
* After it was powered off. If you don't do that then azure API will respond back the VM isn't generalized when creating the source image.
* I then created another VM using the source_image_id of the azure_image created from the target VM. You can see that in the image.tf file.
* Contents:
    * main.tf
    * image.tf
    * variables.tf

## Summary

What this allows me to do is create a source VM in terraform, apply whatever config (hint: I did this manually, but I could have used Ansible/powershell/desired state etc. to apply config), generalize, then create VM from that source image using terraform.
