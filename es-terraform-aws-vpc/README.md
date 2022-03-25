# AWS VPC Network
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/vpn/azurerm/)

AWS vpc Network

## Version compatibility

| Module version | Terraform version |
|----------------|-------------------|
| >= 1.x.x       | 0.14.x            |
| >= 1.x.x       | 0.13.x            |
| >= 1.x.x       | 0.12.x            |

## Resources

* AWS VPC


## Configuration 



## How to Use 

```hcl
data "aws_availability_zones" "available" {
}

module "vpc" {
  source  = "git::https://innersource.soprasteria.com/aceleracion-digital/es_aws_terraform/modules/es-terraform-aws-vpc.git?ref=master"

  name                 = "demo-vpc"
  cidr                 = "10.X.0.X/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.X.1.X/24", "10.X.2.X/24", "10.X.3.0/24"]
  public_subnets       = ["10.X.4.X/24", "10.X.5.X/24", "10.X.6.X/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

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
``
