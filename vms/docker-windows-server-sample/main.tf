provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "docker-windows-server" {
  name     = "docker-windows-server-resources"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "docker-windows-server" {
  name                = "docker-windows-server-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.docker-windows-server.location
  resource_group_name = azurerm_resource_group.docker-windows-server.name
}

resource "azurerm_subnet" "docker-windows-server" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.docker-windows-server.name
  virtual_network_name = azurerm_virtual_network.docker-windows-server.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "docker-windows-server" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.docker-windows-server.name
  location            = azurerm_resource_group.docker-windows-server.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "docker-windows-server" {
  name                = "docker-windows-server-nic"
  location            = azurerm_resource_group.docker-windows-server.location
  resource_group_name = azurerm_resource_group.docker-windows-server.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.docker-windows-server.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.docker-windows-server.id
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_windows_virtual_machine" "docker-windows-server" {
  name                = "docker-windows-server-machine"
  computer_name       = "docker-win-vm"
  resource_group_name = azurerm_resource_group.docker-windows-server.name
  location            = azurerm_resource_group.docker-windows-server.location
  size                = "${var.instance_type}"
  admin_username      = "sergeyd"
  admin_password      = random_password.password.result
  network_interface_ids = [
    azurerm_network_interface.docker-windows-server.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  custom_data = base64encode("${file("./${var.cloudinit_file}")}")
}

resource "azurerm_virtual_machine_extension" "cloudinit" {
  name                 = "cloudinit"
  virtual_machine_id = azurerm_windows_virtual_machine.docker-windows-server.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  settings = <<SETTINGS
    {
        "commandToExecute": "powershell -ExecutionPolicy unrestricted -NoProfile -NonInteractive -command \"cp c:/azuredata/customdata.bin c:/azuredata/install.ps1; c:/azuredata/install.ps1\""
    }
    SETTINGS
}

data "azurerm_public_ip" "docker-windows-server" {
  name                = azurerm_public_ip.docker-windows-server.name
  resource_group_name = azurerm_windows_virtual_machine.docker-windows-server.resource_group_name
  depends_on          = [azurerm_windows_virtual_machine.docker-windows-server]
}