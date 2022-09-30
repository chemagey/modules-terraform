##  Azure Container Service (AKS) Cluster

resource "azurerm_kubernetes_cluster" "aks" {
  name                     = "aks-split-dev"
  location                 = var.location
  resource_group_name      = var.resourceGroup
  dns_prefix               = var.dns_prefix
  kubernetes_version       = var.k8s_version
  node_resource_group      = "node-split-dev"
 
#  linux_profile {
#    admin_username = var.k8s_user
#    ssh_key {
#      key_data = "${file("${var.ssh_key_path}")}"
#    }
#  }

  default_node_pool {
    name                  = "defaultpool"
    node_count            = var.node_count
    //os_type             = "${var.os_type}"
    os_disk_size_gb       = var.os_disk_size_gb
    vm_size               = var.vm_size
    //min_count           = "${var.node_min_count}"
    //max_count           = "${var.node_max_count}"
    //enable_auto_scaling = false
    type                  = "VirtualMachineScaleSets"
    availability_zones    = [1,2,3]
    vnet_subnet_id        = "${data.azurerm_subnet.aks-subnet.id}"
    orchestrator_version  = var.k8s_version
   }


  network_profile {
     network_plugin      = var.network_plugin
     network_policy      = var.network_plugin
     dns_service_ip      = var.dns_service_ip
     docker_bridge_cidr  = var.docker_bridge_cidr
     service_cidr        = var.service_cidr
    load_balancer_sku    = "Standard"
  }

  identity {
    type = "SystemAssigned"
  }

#  service_principal {
#    client_id     = var.azure_client_id
#    client_secret = var.azure_secret_id
#  }

 tags = local.resourceTags
}

resource "azurerm_kubernetes_cluster_node_pool" "aksnodepool" {

  count                  = "${var.additonal_node_pool == "enable" ? 1 : 0}" 
  name                   = var.additonal_node_pool_name
  kubernetes_cluster_id  = azurerm_kubernetes_cluster.aks.id
   node_count            = var.add_node_count
   os_type               = var.add_os_type
   os_disk_size_gb       = var.add_os_disk_size_gb
   vm_size               = var.add_vm_size
   //min_count           = "${var.add_node_min_count}"
   //max_count           = "${var.add_node_max_count}"
   //enable_auto_scaling = false
   availability_zones    = [1,2,3]
   vnet_subnet_id        = "${data.azurerm_subnet.aks-subnet.id}"
   orchestrator_version  = var.k8s_version
   depends_on            = [ azurerm_kubernetes_cluster.aks ]
}
