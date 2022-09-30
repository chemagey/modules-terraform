# Azure Kubernetes Service
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/vpn/azurerm/)


Azure Kubernetes Service (AKS) offers serverless Kubernetes, an integrated continuous integration and continuous delivery (CI/CD) experience and enterprise-grade security and governance. Unite your development and operations teams on a single platform to rapidly build, deliver and scale applications with confidence.

## Version compatibility

| Module version | Terraform version |
|----------------|-------------------|
| >= 1.x.x       | 0.14.x            |
| >= 1.x.x       | 0.13.x            |
| >= 1.x.x       | 0.12.x            |

## Resources

* Azure Kubernetes Service
* Default Node Pool```(VM ScaleSet)```
* Custom Node Pool```(VM ScaleSet)``` 

## Configuration 

The follwoing Options are available to configure Azure Kubernetes Service .

**Kubernetes Network Configuration**

```network_plugin``` (Required) Network plugin to use for networking. Currently supported values are 

* azure 
* kubenet

**Note** - When network_plugin is set to azure - the vnet_subnet_id field in the default_node_pool block must be set and pod_cidr must not be set.

```docker_bridge_cidr -``` (Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created.


```pod_cidr -``` (Optional) The CIDR to use for pod IP addresses. This field can only be set when network_plugin is set to kubenet. Changing this forces a new resource to be created.

```service_cidr -``` (Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created.


| Component           |  IP address       |
|---------------------|-------------------|
| Service CIDR        | 172.16.0.0/16     |
| Service DNS         | 172.16.0.10       |
| Docker bridge CIDR  | 172.17.0.1/16     |

```sh
     network_plugin      = 
     network_policy      = 
     dns_service_ip      = 
     docker_bridge_cidr  = 
     service_cidr        = 
```

**SKU Configuration**

```load_balancer_sku -``` (Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are 

* Basic 
* Standard. ```Defaults to Standard```

**Kubernetes Cluster Configuration**

Define kubernetes version which you want to deploy.

```sh
k8s_version = 1.18.4
```
Define user for kuberetes nodes for ssh connection .

```sh
k8s_user = admin
```

Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false .

```sh
private_cluster_enabled = 
```

Either the ID of Private DNS Zone which should be delegated to this Cluster, or System to have AKS manage this .

```sh
private_dns_zone_id = 
```

**Kubernetes Node Pool**


## How to Use 

```hcl
module "aks" {
  source  = "https://innersource.soprasteria.com/group-cloud-coe/cloudnetes/modules/azure/terraform-azure-akscluster.git"
  version = "1.0.0"

  prefix = 
  project_prefix = 
  project = 
  environment = 
  location = 

  environment_owner = 
  environment_costcenter =
  environment_controller =

  
  }
```

## Deploy Resources  

**Initialize terraform module**

```sh
terraform init 
```
**Plan terraform module**

```sh
terraform plan 
```

**Deploy terraform module**

```sh
terraform apply 
```

## Destroy Resources 

**Destroy terraform module**

```sh
terraform destroy
```
