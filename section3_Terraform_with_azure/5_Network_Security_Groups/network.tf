resource "azurerm_network_security_group" "allow-ssh" {
  name = "${var.prefix}-allow-ssh"
  location = var.location
  resource_group_name = azurerm_resource_group.demo.name

  security_rule {
    name = "SSH"
    priority = 1001
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = var.ssh-source-address
    destination_address_prefix = "*"
  }
}
