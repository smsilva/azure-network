resource "azurerm_public_ip" "pip_hub_bastion" {
  name                = "pip_hub_bastion"
  allocation_method   = "Static"
  sku                 = "Standard"
  location            = module.shared_network_configuration.vnets["hub"].resource_group.location
  resource_group_name = module.shared_network_configuration.vnets["hub"].resource_group.name

  depends_on = [
    module.shared_network_configuration
  ]
}

resource "azurerm_bastion_host" "hub_bastion" {
  name                = "hub_bastion"
  location            = module.shared_network_configuration.vnets["hub"].resource_group.location
  resource_group_name = module.shared_network_configuration.vnets["hub"].resource_group.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = module.shared_network_configuration.subnets["AzureBastionSubnet"].instance.id
    public_ip_address_id = azurerm_public_ip.pip_hub_bastion.id
  }
}

resource "azurerm_virtual_network_peering" "hub_to_spoke_one" {
  name                      = "hubtospokeone"
  resource_group_name       = module.shared_network_configuration.vnets["hub"].resource_group.name
  virtual_network_name      = module.shared_network_configuration.vnets["hub"].name
  remote_virtual_network_id = module.shared_network_configuration.vnets["spokeone"].id
}

resource "azurerm_virtual_network_peering" "spoke_one_to_hub" {
  name                      = "spokeonetohub"
  resource_group_name       = module.shared_network_configuration.vnets["spokeone"].resource_group.name
  virtual_network_name      = module.shared_network_configuration.vnets["spokeone"].name
  remote_virtual_network_id = module.shared_network_configuration.vnets["hub"].id
}

resource "azurerm_network_interface" "nic_example" {
  name                = "nic-example"
  location            = module.shared_network_configuration.vnets["spokeone"].resource_group.location
  resource_group_name = module.shared_network_configuration.vnets["spokeone"].resource_group.name

  ip_configuration {
    name                          = "exampleconfiguration"
    subnet_id                     = module.shared_network_configuration.subnets["snet-cluternodes"].instance.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-machine"
  location            = module.shared_network_configuration.vnets["spokeone"].resource_group.location
  resource_group_name = module.shared_network_configuration.vnets["spokeone"].resource_group.name
  size                = "Standard_F2"
  admin_username      = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.nic_example.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
