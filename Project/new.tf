provider "azurerm" {
  version = "=2.4.0"

  subscription_id = ""
  client_id       = ""
  client_secret   = ""
  tenant_id       = ""

  features {}
}

resource "azurerm_resource_group" "resource" {
  name     = "projectresource"
  location = "West US 2"
}

resource "azurerm_virtual_network" "network" {
  name                = "projectnetwork"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.resource.location
  resource_group_name = azurerm_resource_group.resource.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "projectsub"
  resource_group_name  = azurerm_resource_group.resource.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_public_ip" "public" {
  name                    = "projectpublic"
  location                = azurerm_resource_group.resource.location
  resource_group_name     = azurerm_resource_group.resource.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30


}

resource "azurerm_network_interface" "interface" {
  name                = "projectinterface"
  location            = azurerm_resource_group.resource.location
  resource_group_name = azurerm_resource_group.resource.name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.5"
    public_ip_address_id          = azurerm_public_ip.public.id
  }
}

resource "azurerm_network_security_group" "sg" {
  name                = "projectsecurity"
  location            = azurerm_resource_group.resource.location
  resource_group_name = azurerm_resource_group.resource.name
  security_rule {
    name                       = "ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ping"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "ICMP"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.sg.id
}
resource "azurerm_virtual_machine" "newvm" {
  name                  = "projectvm"
  location              = azurerm_resource_group.resource.location
  resource_group_name   = azurerm_resource_group.resource.name
  network_interface_ids = [azurerm_network_interface.interface.id]
  vm_size               = "Standard_DS1_v2"
   storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "Storagenew"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "Origins@123"
    admin_password = "Hubs!12345"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}
resource "azurerm_storage_account" "storage" {
  name                     = "storagenewproject"
  resource_group_name      = azurerm_resource_group.resource.name
  location                 = azurerm_resource_group.resource.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

output "public_ip_address" {
  value = azurerm_public_ip.public.ip_address
}
