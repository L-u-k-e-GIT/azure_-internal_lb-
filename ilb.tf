
/*
resource "azurerm_lb" "ilp_ip" {
  name                = "${var.MD_IIP_PREFIX}-${var.MD_PROJECT_NAME}-${var.MD_SUBSCRIPTION_PREFIX}-${var.MD_REGION_PREFIX}-001"
  location            = var.MD_LOCATION
  resource_group_name = var.MD_RG_NAME
  allocation_method   = "Static"
}
*/

#ilb-transit-azfk-hub-001

# ----------------- Create Load balancing -----------------

resource "azurerm_lb" "ilb-001" {
  name                = "${var.MD_ILP_PREFIX}-${var.MD_PROJECT_NAME}-${var.MD_SUBSCRIPTION_PREFIX}-${var.MD_REGION_PREFIX}-001"
  location            = var.MD_LOCATION
  resource_group_name = var.MD_RG_NAME
  sku                 = "Standard"
  sku_tier            = "Regional"
  
  frontend_ip_configuration {
    name                          = "${var.MD_IIP_PREFIX}-${var.MD_PROJECT_NAME}-${var.MD_SUBSCRIPTION_PREFIX}-${var.MD_REGION_PREFIX}-001"
    subnet_id                     = var.MD_SUBNET_ID
    private_ip_address_version    = "IPv4"
    }
    lifecycle {
    ignore_changes = [
     tags
    ]
  }
}


resource "azurerm_lb_backend_address_pool" "lbp-001" {
  name            = "${var.MD_LBP_PREFIX}-${var.MD_PROJECT_NAME}-${var.MD_SUBSCRIPTION_PREFIX}-${var.MD_REGION_PREFIX}-001"
  loadbalancer_id = azurerm_lb.ilb-001.id
    depends_on = [
    azurerm_lb.ilb-001
  ]
}


resource "azurerm_network_interface_backend_address_pool_association" "lbp-nic" {
  for_each                      = var.MD_VM_NIC
  network_interface_id          = each.value.id
  ip_configuration_name         = var.MD_VM_NIC_CONFIG
  backend_address_pool_id       = azurerm_lb_backend_address_pool.lbp-001.id
  
}



resource "azurerm_lb_probe" "ilb_probe" {
  loadbalancer_id     = azurerm_lb.ilb-001.id
  name                ="${var.MD_LBHP_PREFIX}-${var.MD_PROJECT_NAME}-${var.MD_SUBSCRIPTION_PREFIX}-${var.MD_REGION_PREFIX}-001"
  port                = var.MD_LB_PORT
  interval_in_seconds = 5
  number_of_probes    = 2
  
 }




resource "azurerm_lb_rule" "lbr-transit-azfk-hub-001" {
  
  name                           ="${var.MD_LBR_PREFIX}-${var.MD_PROJECT_NAME}-${var.MD_SUBSCRIPTION_PREFIX}-${var.MD_REGION_PREFIX}-001"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lbp-001.id]
  loadbalancer_id                = azurerm_lb.ilb-001.id
  protocol                       = var.MD_LB_PROTOCOL
  frontend_port                  = var.MD_LB_PORT
  backend_port                   = var.MD_LB_PORT
  frontend_ip_configuration_name = azurerm_lb.ilb-001.frontend_ip_configuration[0].name
  probe_id                       = azurerm_lb_probe.ilb_probe.id
  
}

