/*
   Variables for AKS cluster module
*/


/**********************************************
Provider details
**********************************************/
variable "subscription_id" {
  description = "subscription id:"
  default = "fbdc854d-0085-4a95-a601-ba856900e6ab"
}
variable "tenant_id" {
  description = "tenant id:"
  default = "85173d93-99ef-4dff-9b45-495719659133"
}


#/**********************************
#Service Principal details
#***********************************/
#
#variable "azure_client_id" {
#  description = "client id:"
#  default = "27f06888-1663-408b-a22e-ab9adf3d6277"
#}
#variable "azure_secret_id" {
#  description = "client secret password:"
#  default = "90718f0f-9766-4ba5-835c-bfab3a7757bd"
#}


/************************************************
Global Variables
*************************************************/
variable "resourceGroup" {
  description = "Project Prefix:"
  default = "Enagas-AKS-dev"
}

variable "vnetName" {
  description = "Virtual Network Name:"
  default = "enagas-aks"
}

variable "aksSubnetName" {
  description = "Subnet Name for AKS:"
  default = "subnet-enagas-split"
}

variable "aksClusterName" {
  description = "Cluster Name for AKS:"
  default = "split-dev"
}

variable "dns_prefix" {
  description = "DNS prefix for AKS:"
  default = "cluster-split-dev"
}

variable "location" {
  description = "Location:"
  default     = "westeurope"
}


/************************************************
Global Tags
*************************************************/
variable "environment_owner" {
  description = "Environment-owner Name:"
  default     = "ccoe"
}
variable "environment_costcenter" {
  description = "Environment-costcenter Name:"
  default     = "ccoe"
}
variable "environment_controller" {
  description = "Environment-controller Name:"
  default     = "ccoe"
}

/************************************************
AKS Cluster Variables
*************************************************/

variable "k8s_version" {
  description = "Kubernetes version"
  default     = "1.21.7"
}
/***** Linux profile *******/

variable "k8s_user" {
  description = "Kubernetes user"
  default     = "aksuser"
}
variable "ssh_key_path" {
  description = "Kubernetes ssh key file path like sshkey/example_rsa_id.pub"
  default     = "~/.ssh/id_ed25519.pub"
}

/****** Network profile ******/

variable "network_plugin" {
  description = "Network plugin"
  default     = "azure"
}
variable "dns_service_ip" {
  description = "DNS Service IP"
  default     = "172.16.0.10"
}
variable "docker_bridge_cidr" {
  description = "Docker Bridge CIDR"
  default     = "172.17.0.1/16"
}
variable "service_cidr" {
  description = "Service CIDR"
  default     = "172.16.0.0/16"
}

/*****  Default node pool *******/

variable "node_count" {
  description = "Kubernetes default pool node count"
  default     = "1"
}
variable "os_type" {
  description = "Kubernetes default pool node os type"
  default     = "Linux"
}
variable "os_disk_size_gb" {
  description = "Kubernetes default pool node os disk size in GB"
  default     = "32"
}
variable "vm_size" {
  description = "Kubernetes default pool node vm size "
  default     = "Standard_DS3_v2"
}

/*******************************
Default node pool Autoscaling 
********************************/

variable "node_min_count" {
  description = "Kubernetes default pool node min count"
  default     = "1"
}
variable "node_max_count" {
  description = "Kubernetes default pool node max count"
  default     = "1"
}
/*variable "auto_scaling" {
  description = "Kubernetes default pool auto scaling true/false"
}*/


/***************************
Additional node pool 
****************************/

variable "additonal_node_pool" {
  description = "Create Kubernetes Additional pool node pool"
  default     = "enable"
}

variable "additonal_node_pool_name" {
  description = "Kubernetes Additional pool node name"
  default     = "extrapool"
}

variable "add_node_count" {
  description = "Kubernetes Additional pool node count"
  default     = "1"
}
variable "add_os_type" {
  description = "Kubernetes Additional pool node os type"
  default     = "Linux"
}
variable "add_os_disk_size_gb" {
  description = "Kubernetes Additional pool node os disk size in GB"
  default     = "32"
}
variable "add_vm_size" {
  description = "Kubernetes Additional pool node vm size "
  default     = "Standard_D3_v2"
}

/******************************
Autoscaling for additional pool
*******************************/

variable "add_node_min_count" {
  description = "Kubernetes Additional pool node min count"
  default     = "1"
}
variable "add_node_max_count" {
  description = "Kubernetes Additional pool node max count"
  default     = "1"
}
/*variable "add_auto_scaling" {
 description = "Kubernetes Additional pool auto scaling true/false"
}*/
