provider "azurerm" {
#   subscription_id = var.subscription_id
#   client_id       = var.client_id
#   client_secret   = var.client_secret
#   tenant_id       = var.tenant_id
  skip_provider_registration = "true"
  features {}
}

resource "azurerm_resource_group" "iac-poc-tf" {
  name     = var.resourcegroup
  location = "${var.location}"
}

resource "azurerm_virtual_network" "iac-poc-tf" {
  name                = "iac-poc-tf-network"
  address_space       = ["172.0.0.0/16"]
  location            = azurerm_resource_group.iac-poc-tf.location
  resource_group_name = azurerm_resource_group.iac-poc-tf.name
}

resource "azurerm_subnet" "iac-poc-tf" {
  name                 = "iac-poc-tf-subnet-internal"
  resource_group_name  = azurerm_resource_group.iac-poc-tf.name
  virtual_network_name = azurerm_virtual_network.iac-poc-tf.name
  address_prefixes     = ["172.0.2.0/24"]
}

resource "azurerm_public_ip" "iac-poc-tf" {
  name                = "iac-poc-tf-public-ip"
  resource_group_name = azurerm_resource_group.iac-poc-tf.name
  location            = azurerm_resource_group.iac-poc-tf.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "iac-poc-tf" {
  name                = "iac-poc-tf-nic"
  location            = azurerm_resource_group.iac-poc-tf.location
  resource_group_name = azurerm_resource_group.iac-poc-tf.name

  ip_configuration {
    name                          = "iac-poc-tf-nic-internal"
    subnet_id                     = azurerm_subnet.iac-poc-tf.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.iac-poc-tf.id
  }
}

resource "random_password" "iac-poc-tf" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_linux_virtual_machine" "iac-poc-tf" {
  name                = "iac-poc-tf-machine"
  computer_name       = "iacp-linux-vm"
  resource_group_name = azurerm_resource_group.iac-poc-tf.name
  location            = azurerm_resource_group.iac-poc-tf.location
  size                = "${var.instance_type}"
  admin_username      = "sergeyd"
  admin_password      = random_password.iac-poc-tf.result
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.iac-poc-tf.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  custom_data = base64encode("${file("./${var.cloudinit_file}")}")
}

# resource "azurerm_virtual_machine_extension" "cloudinit" {
#   name                 = "cloudinit"
#   virtual_machine_id = azurerm_windows_virtual_machine.iac-poc-tf.id
#   publisher            = "Microsoft.Compute"
#   type                 = "CustomScriptExtension"
#   type_handler_version = "1.172"
#   settings = <<SETTINGS
#     {
#         "commandToExecute": "powershell -ExecutionPolicy unrestricted -NoProfile -NonInteractive -command \"cp c:/azuredata/customdata.bin c:/azuredata/install.ps1; c:/azuredata/install.ps1\""
#     }
#     SETTINGS
# }

data "azurerm_public_ip" "iac-poc-tf" {
  name                = azurerm_public_ip.iac-poc-tf.name
  resource_group_name = azurerm_windows_virtual_machine.iac-poc-tf.resource_group_name
  depends_on          = [azurerm_windows_virtual_machine.iac-poc-tf]
}
