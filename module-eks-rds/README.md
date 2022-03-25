# Modulo de RDS/Dyanmo + EKS

El proposito del módulo es el de crear una base de datos RDS (postgre, oracle o aurora) o una tabla de Dynamo junto con un cluster de EKS de manera que facilite la creación de estos recursos cumpliendo los estandares definidos.

# Características

- Crear un clúster EKS
- Se admiten todos los tipos de nodos:
  - [Grupos de nodos gestionados](https://docs.aws.amazon.com/eks/latest/userguide/managed-node-groups.html)
  - [Nodos autogestionados](https://docs.aws.amazon.com/eks/latest/userguide/worker.html)
  - [Fargate](https://docs.aws.amazon.com/eks/latest/userguide/fargate.html)
- Soporta AWS EKS Optimized o Custom AMI
- Crear o gestionar grupos de seguridad que permitan la comunicación y la coordinación


Módulo Terraform que crea recursos RDS en AWS.

El módulo raíz llama a estos módulos que también pueden ser utilizados por separado para crear recursos independientes:

- [db_instance](https://github.com/terraform-aws-modules/terraform-aws-rds/tree/master/modules/db_instance) - crea una instancia de base de datos RDS
- [db_subnet_group](https://github.com/terraform-aws-modules/terraform-aws-rds/tree/master/modules/db_subnet_group) - crea un grupo de subred de BD RDS
- [db_parameter_group](https://github.com/terraform-aws-modules/terraform-aws-rds/tree/master/modules/db_parameter_group) - crea un grupo de parámetros de la base de datos RDS
- db_option_group](https://github.com/terraform-aws-modules/terraform-aws-rds/tree/master/modules/db_option_group) - crea un grupo de opciones de la base de datos RDS

Módulo Terraform que crea recursos RDS aurora en AWS.
- Autoescalado de réplicas de lectura
- Clúster global
- Monitorización mejorada
- Clúster sin servidor
- Importación desde S3
- Control detallado de las instancias individuales del clúster
- Puntos finales personalizados


# Uso


## Ejemplo eks + oracle rds

### main.tf
``` hcl
module "main" {
  source         = "git::https://github.com/enagas-devops/module-eks-rds.git"
  username       = var.username
  nivel_servicio = var.nivel_servicio
  db_type        = var.db_type
  prefix         = var.prefix
  environment    = var.environment
  project        = var.project

  database_name     = var.database_name
  allocated_storage = var.allocated_storage
  instance_class    = var.instance_class
  create_eks        = true

  labels = var.labels

  domain_iam_role_name   = "role-foo-example"
  vpc_id                 = "vpc-123412341234"
  vpc_security_group_ids = ["sg-123412341234"]
  db_subnet_ids          = ["subnet-123412341234", "subnet-123421342134"]


   cluster_iam_role_name = "role-foo-example"
   eks_subnets           = ["subnet-1234123412341234", "subnet-12342134214214"]
}
```

### terraform.tfvars
``` hcl
username          = "pepe"
password          = "epeppepe"
nivel_servicio    = "plata"
db_type           = "oracle"
prefix            = "enagas"
environment       = "dev"
project           = "scp"
database_name     = "Enagas"
allocated_storage = 100
instance_class    = "db.t3.medium"
labels = {
  "sociedad"             = "gts"
  "direccion_demandante" = "dgral_gts"
  "unidad_pagadora"      = "d_digitalizacion"
  "programa"             = "cu_acciones_balance"
  "proveedor"            = "piperlab"

  "servicio"   = "cu_acciones_balance"
  "aplicacion" = "cu_acciones_balance"
  "entorno"    = "des"
  "nombre"     = "cu_acciones_balance"

  "calendario"     = "plata"
  "mantenimiento"  = "plata"
  "iac"            = true
  "automatizacion" = true

  "confidencialidad" = "critico"
  "normativa"        = "na"
}
cluster_iam_role_name = "enagas-scp-dev-rdsoracle"
```
## Example aurora without EKS

### main.tf
``` hcl
module "main" {
  source         = "git::https://github.com/enagas-devops/module-eks-rds.git"
  username       = var.username
  nivel_servicio = var.nivel_servicio
  db_type        = var.db_type
  prefix         = var.prefix
  environment    = var.environment
  project        = var.project

  database_name     = var.database_name
  allocated_storage = var.allocated_storage
  instance_class    = var.instance_class
  create_eks        = false

  labels = var.labels

  vpc_id                 = "vpc-123412341234"
  vpc_security_group_ids = ["sg-123412341234"]
  db_subnet_ids          = ["subnet-123412341234", "subnet-123421342134"]

  parameters = [{
    apply_method = "pending-reboot"
    name         = "max_parallel_maintenance_workers"
    value        = "15"
    },
    {
      apply_method = "pending-reboot"
      name         = "max_locks_per_transaction"
      value        = "65"
  }]
  instance_parameters = [{
    apply_method = "pending-reboot"
    name         = "max_parallel_maintenance_workers"
    value        = "15"
    },
    {
      apply_method = "pending-reboot"
      name         = "max_locks_per_transaction"
      value        = "65"
  }]
  cluster_parameters = [{
    name  = "max_prepared_transactions"
    value = "10"
    }
  ]

}
```

### terraform.tfvars
``` hcl
username          = "pepe"
password          = "epeppepe"
nivel_servicio    = "plata"
db_type           = "aurora"
prefix            = "enagas"
environment       = "dev"
project           = "scp"
database_name     = "Enagas"
allocated_storage = 100
instance_class    = "db.t3.medium"
labels = {
  "sociedad"             = "gts"
  "direccion_demandante" = "dgral_gts"
  "unidad_pagadora"      = "d_digitalizacion"
  "programa"             = "cu_acciones_balance"
  "proveedor"            = "piperlab"

  "servicio"   = "cu_acciones_balance"
  "aplicacion" = "cu_acciones_balance"
  "entorno"    = "des"
  "nombre"     = "cu_acciones_balance"

  "calendario"     = "plata"
  "mantenimiento"  = "plata"
  "iac"            = true
  "automatizacion" = true

  "confidencialidad" = "critico"
  "normativa"        = "na"
}
cluster_iam_role_name = "enagas-scp-dev-rdsoracle"
```
<!--- BEGIN_TF_DOCS --->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aurora"></a> [aurora](#module\_aurora) | terraform-aws-modules/rds-aurora/aws | n/a |
| <a name="module_dynamodb"></a> [dynamodb](#module\_dynamodb) | terraform-aws-modules/dynamodb-table/aws | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | n/a |
| <a name="module_rds"></a> [rds](#module\_rds) | terraform-aws-modules/rds/aws | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_db_parameter_group.instance_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_parameter_group.parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_rds_cluster_parameter_group.cluster_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | Tamaño de la base de datos | `number` | `null` | no |
| <a name="input_allow_major_version_upgrade"></a> [allow\_major\_version\_upgrade](#input\_allow\_major\_version\_upgrade) | n/a | `bool` | `false` | no |
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | n/a | `list(string)` | `[]` | no |
| <a name="input_allowed_security_groups"></a> [allowed\_security\_groups](#input\_allowed\_security\_groups) | n/a | `list(string)` | `[]` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | n/a | `bool` | `false` | no |
| <a name="input_attach_worker_cni_policy"></a> [attach\_worker\_cni\_policy](#input\_attach\_worker\_cni\_policy) | n/a | `bool` | `true` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | n/a | `list(map(string))` | `[]` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | n/a | `bool` | `false` | no |
| <a name="input_autoscaling_defaults"></a> [autoscaling\_defaults](#input\_autoscaling\_defaults) | n/a | `map(string)` | <pre>{<br>  "scale_in_cooldown": 0,<br>  "scale_out_cooldown": 0,<br>  "target_value": 70<br>}</pre> | no |
| <a name="input_autoscaling_enabled"></a> [autoscaling\_enabled](#input\_autoscaling\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_autoscaling_indexes"></a> [autoscaling\_indexes](#input\_autoscaling\_indexes) | n/a | `map(map(string))` | `{}` | no |
| <a name="input_autoscaling_max_capacity"></a> [autoscaling\_max\_capacity](#input\_autoscaling\_max\_capacity) | n/a | `number` | `2` | no |
| <a name="input_autoscaling_min_capacity"></a> [autoscaling\_min\_capacity](#input\_autoscaling\_min\_capacity) | n/a | `number` | `1` | no |
| <a name="input_autoscaling_read"></a> [autoscaling\_read](#input\_autoscaling\_read) | n/a | `map(string)` | `{}` | no |
| <a name="input_autoscaling_scale_in_cooldown"></a> [autoscaling\_scale\_in\_cooldown](#input\_autoscaling\_scale\_in\_cooldown) | n/a | `number` | `300` | no |
| <a name="input_autoscaling_scale_out_cooldown"></a> [autoscaling\_scale\_out\_cooldown](#input\_autoscaling\_scale\_out\_cooldown) | n/a | `number` | `300` | no |
| <a name="input_autoscaling_target_connections"></a> [autoscaling\_target\_connections](#input\_autoscaling\_target\_connections) | n/a | `number` | `700` | no |
| <a name="input_autoscaling_target_cpu"></a> [autoscaling\_target\_cpu](#input\_autoscaling\_target\_cpu) | n/a | `number` | `70` | no |
| <a name="input_autoscaling_write"></a> [autoscaling\_write](#input\_autoscaling\_write) | n/a | `map(string)` | `{}` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | n/a | `string` | `"eu-west-1a"` | no |
| <a name="input_aws_auth_additional_labels"></a> [aws\_auth\_additional\_labels](#input\_aws\_auth\_additional\_labels) | n/a | `map(string)` | `null` | no |
| <a name="input_backtrack_window"></a> [backtrack\_window](#input\_backtrack\_window) | n/a | `number` | `0` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | n/a | `number` | `30` | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | n/a | `string` | `null` | no |
| <a name="input_billing_mode"></a> [billing\_mode](#input\_billing\_mode) | n/a | `string` | `"PAY_PER_REQUEST"` | no |
| <a name="input_ca_cert_identifier"></a> [ca\_cert\_identifier](#input\_ca\_cert\_identifier) | n/a | `string` | `"rds-ca-2019"` | no |
| <a name="input_character_set_name"></a> [character\_set\_name](#input\_character\_set\_name) | n/a | `string` | `"UTF8"` | no |
| <a name="input_cluster_create_endpoint_private_access_sg_rule"></a> [cluster\_create\_endpoint\_private\_access\_sg\_rule](#input\_cluster\_create\_endpoint\_private\_access\_sg\_rule) | n/a | `bool` | `false` | no |
| <a name="input_cluster_create_security_group"></a> [cluster\_create\_security\_group](#input\_cluster\_create\_security\_group) | n/a | `bool` | `false` | no |
| <a name="input_cluster_create_timeout"></a> [cluster\_create\_timeout](#input\_cluster\_create\_timeout) | n/a | `string` | `"30m"` | no |
| <a name="input_cluster_delete_timeout"></a> [cluster\_delete\_timeout](#input\_cluster\_delete\_timeout) | n/a | `string` | `"15m"` | no |
| <a name="input_cluster_egress_cidrs"></a> [cluster\_egress\_cidrs](#input\_cluster\_egress\_cidrs) | n/a | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_cluster_enabled_log_types"></a> [cluster\_enabled\_log\_types](#input\_cluster\_enabled\_log\_types) | n/a | `list(string)` | <pre>[<br>  "api",<br>  "audit"<br>]</pre> | no |
| <a name="input_cluster_endpoint_private_access"></a> [cluster\_endpoint\_private\_access](#input\_cluster\_endpoint\_private\_access) | n/a | `bool` | `true` | no |
| <a name="input_cluster_endpoint_private_access_cidrs"></a> [cluster\_endpoint\_private\_access\_cidrs](#input\_cluster\_endpoint\_private\_access\_cidrs) | n/a | `list(string)` | <pre>[<br>  "10.140.0.0/16",<br>  "10.141.0.0/16"<br>]</pre> | no |
| <a name="input_cluster_endpoint_private_access_sg"></a> [cluster\_endpoint\_private\_access\_sg](#input\_cluster\_endpoint\_private\_access\_sg) | n/a | `list(string)` | `[]` | no |
| <a name="input_cluster_endpoint_public_access"></a> [cluster\_endpoint\_public\_access](#input\_cluster\_endpoint\_public\_access) | n/a | `bool` | `false` | no |
| <a name="input_cluster_endpoint_public_access_cidrs"></a> [cluster\_endpoint\_public\_access\_cidrs](#input\_cluster\_endpoint\_public\_access\_cidrs) | n/a | `list(string)` | `[]` | no |
| <a name="input_cluster_iam_role_name"></a> [cluster\_iam\_role\_name](#input\_cluster\_iam\_role\_name) | n/a | `string` | `null` | no |
| <a name="input_cluster_log_kms_key_id"></a> [cluster\_log\_kms\_key\_id](#input\_cluster\_log\_kms\_key\_id) | n/a | `string` | `null` | no |
| <a name="input_cluster_log_retention_in_days"></a> [cluster\_log\_retention\_in\_days](#input\_cluster\_log\_retention\_in\_days) | n/a | `number` | `null` | no |
| <a name="input_cluster_parameters"></a> [cluster\_parameters](#input\_cluster\_parameters) | n/a | `list(map(string))` | `null` | no |
| <a name="input_cluster_security_group_id"></a> [cluster\_security\_group\_id](#input\_cluster\_security\_group\_id) | n/a | `string` | `null` | no |
| <a name="input_cluster_service_ipv4_cidr"></a> [cluster\_service\_ipv4\_cidr](#input\_cluster\_service\_ipv4\_cidr) | n/a | `string` | `null` | no |
| <a name="input_cluster_timeouts"></a> [cluster\_timeouts](#input\_cluster\_timeouts) | n/a | `map(string)` | `{}` | no |
| <a name="input_cluster_update_timeout"></a> [cluster\_update\_timeout](#input\_cluster\_update\_timeout) | n/a | `string` | `"60m"` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | n/a | `string` | `null` | no |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | n/a | `bool` | `true` | no |
| <a name="input_create_cluster"></a> [create\_cluster](#input\_create\_cluster) | n/a | `bool` | `true` | no |
| <a name="input_create_db_instance"></a> [create\_db\_instance](#input\_create\_db\_instance) | n/a | `bool` | `true` | no |
| <a name="input_create_db_option_group"></a> [create\_db\_option\_group](#input\_create\_db\_option\_group) | n/a | `bool` | `true` | no |
| <a name="input_create_db_parameter_group"></a> [create\_db\_parameter\_group](#input\_create\_db\_parameter\_group) | n/a | `bool` | `true` | no |
| <a name="input_create_db_subnet_group"></a> [create\_db\_subnet\_group](#input\_create\_db\_subnet\_group) | n/a | `bool` | `true` | no |
| <a name="input_create_eks"></a> [create\_eks](#input\_create\_eks) | Crear o no un cluster de eks. | `bool` | `true` | no |
| <a name="input_create_eks_resources"></a> [create\_eks\_resources](#input\_create\_eks\_resources) | n/a | `bool` | `true` | no |
| <a name="input_create_fargate_pod_execution_role"></a> [create\_fargate\_pod\_execution\_role](#input\_create\_fargate\_pod\_execution\_role) | n/a | `bool` | `false` | no |
| <a name="input_create_monitoring_role"></a> [create\_monitoring\_role](#input\_create\_monitoring\_role) | n/a | `bool` | `false` | no |
| <a name="input_create_random_password"></a> [create\_random\_password](#input\_create\_random\_password) | n/a | `bool` | `false` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | n/a | `bool` | `true` | no |
| <a name="input_create_table"></a> [create\_table](#input\_create\_table) | n/a | `bool` | `true` | no |
| <a name="input_cross_region_replica"></a> [cross\_region\_replica](#input\_cross\_region\_replica) | n/a | `bool` | `false` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Nombre de la base de datos | `string` | `null` | no |
| <a name="input_db_cluster_db_instance_parameter_group_name"></a> [db\_cluster\_db\_instance\_parameter\_group\_name](#input\_db\_cluster\_db\_instance\_parameter\_group\_name) | n/a | `string` | `null` | no |
| <a name="input_db_cluster_parameter_group_name"></a> [db\_cluster\_parameter\_group\_name](#input\_db\_cluster\_parameter\_group\_name) | n/a | `string` | `null` | no |
| <a name="input_db_parameter_group_name"></a> [db\_parameter\_group\_name](#input\_db\_parameter\_group\_name) | n/a | `string` | `null` | no |
| <a name="input_db_subnet_group_description"></a> [db\_subnet\_group\_description](#input\_db\_subnet\_group\_description) | n/a | `string` | `""` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | n/a | `string` | `null` | no |
| <a name="input_db_subnet_group_use_name_prefix"></a> [db\_subnet\_group\_use\_name\_prefix](#input\_db\_subnet\_group\_use\_name\_prefix) | n/a | `bool` | `false` | no |
| <a name="input_db_subnet_ids"></a> [db\_subnet\_ids](#input\_db\_subnet\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_db_type"></a> [db\_type](#input\_db\_type) | Tipo de base de datos que se desea desplegar, aurora, oracle, dynamo o postge. Si se deja sin especificar no se crea base de datos | `string` | `""` | no |
| <a name="input_default_platform"></a> [default\_platform](#input\_default\_platform) | n/a | `string` | `"linux"` | no |
| <a name="input_delete_automated_backups"></a> [delete\_automated\_backups](#input\_delete\_automated\_backups) | n/a | `bool` | `true` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | n/a | `bool` | `false` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | `""` | no |
| <a name="input_domain_iam_role_name"></a> [domain\_iam\_role\_name](#input\_domain\_iam\_role\_name) | n/a | `string` | `null` | no |
| <a name="input_eks_name"></a> [eks\_name](#input\_eks\_name) | ############################################################ ##                     VARIABLES EKS                     ### ############################################################ | `string` | `null` | no |
| <a name="input_eks_oidc_root_ca_thumbprint"></a> [eks\_oidc\_root\_ca\_thumbprint](#input\_eks\_oidc\_root\_ca\_thumbprint) | n/a | `string` | `"9e99a48a9960b14926bb7f3b02e22da2b0ab7280"` | no |
| <a name="input_eks_subnets"></a> [eks\_subnets](#input\_eks\_subnets) | n/a | `list(string)` | `null` | no |
| <a name="input_enable_global_write_forwarding"></a> [enable\_global\_write\_forwarding](#input\_enable\_global\_write\_forwarding) | n/a | `bool` | `false` | no |
| <a name="input_enable_http_endpoint"></a> [enable\_http\_endpoint](#input\_enable\_http\_endpoint) | n/a | `bool` | `false` | no |
| <a name="input_enable_irsa"></a> [enable\_irsa](#input\_enable\_irsa) | n/a | `bool` | `false` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | n/a | `list(string)` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Entorno en el que se se vana  desplegar los recursos. Los valores deben ser dev, pre y pro | `string` | n/a | yes |
| <a name="input_fargate_pod_execution_role_name"></a> [fargate\_pod\_execution\_role\_name](#input\_fargate\_pod\_execution\_role\_name) | n/a | `string` | `null` | no |
| <a name="input_fargate_profiles"></a> [fargate\_profiles](#input\_fargate\_profiles) | n/a | `map(string)` | `{}` | no |
| <a name="input_fargate_subnets"></a> [fargate\_subnets](#input\_fargate\_subnets) | n/a | `list(string)` | `null` | no |
| <a name="input_final_snapshot_identifier_prefix"></a> [final\_snapshot\_identifier\_prefix](#input\_final\_snapshot\_identifier\_prefix) | n/a | `string` | `"final"` | no |
| <a name="input_global_cluster_identifier"></a> [global\_cluster\_identifier](#input\_global\_cluster\_identifier) | n/a | `string` | `null` | no |
| <a name="input_global_secondary_indexes"></a> [global\_secondary\_indexes](#input\_global\_secondary\_indexes) | n/a | `any` | `[]` | no |
| <a name="input_hash_key"></a> [hash\_key](#input\_hash\_key) | ############################################################ ##                     VARIABLES DYNAMO                  ### ############################################################ | `string` | `"id"` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | n/a | `string` | `"/eks/"` | no |
| <a name="input_iam_role_force_detach_policies"></a> [iam\_role\_force\_detach\_policies](#input\_iam\_role\_force\_detach\_policies) | n/a | `bool` | `false` | no |
| <a name="input_iam_role_managed_policy_arns"></a> [iam\_role\_managed\_policy\_arns](#input\_iam\_role\_managed\_policy\_arns) | n/a | `list(string)` | `[]` | no |
| <a name="input_iam_role_max_session_duration"></a> [iam\_role\_max\_session\_duration](#input\_iam\_role\_max\_session\_duration) | n/a | `number` | `0` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | n/a | `string` | `null` | no |
| <a name="input_iam_role_path"></a> [iam\_role\_path](#input\_iam\_role\_path) | n/a | `string` | `"/"` | no |
| <a name="input_iam_role_permissions_boundary"></a> [iam\_role\_permissions\_boundary](#input\_iam\_role\_permissions\_boundary) | n/a | `string` | `""` | no |
| <a name="input_iam_role_use_name_prefix"></a> [iam\_role\_use\_name\_prefix](#input\_iam\_role\_use\_name\_prefix) | n/a | `bool` | `false` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Identificador de la base de datos RDS. | `string` | `null` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | Tipos de instancia utilizada para las instancias de base de datos | `string` | `""` | no |
| <a name="input_instance_parameters"></a> [instance\_parameters](#input\_instance\_parameters) | n/a | `list(map(string))` | `null` | no |
| <a name="input_instance_timeouts"></a> [instance\_timeouts](#input\_instance\_timeouts) | n/a | `map(string)` | `{}` | no |
| <a name="input_instances"></a> [instances](#input\_instances) | n/a | `any` | <pre>{<br>  "1": {}<br>}</pre> | no |
| <a name="input_instances_use_identifier_prefix"></a> [instances\_use\_identifier\_prefix](#input\_instances\_use\_identifier\_prefix) | n/a | `bool` | `false` | no |
| <a name="input_iops"></a> [iops](#input\_iops) | n/a | `number` | `0` | no |
| <a name="input_is_primary_cluster"></a> [is\_primary\_cluster](#input\_is\_primary\_cluster) | n/a | `bool` | `true` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | n/a | `string` | `null` | no |
| <a name="input_kubeconfig_aws_authenticator_additional_args"></a> [kubeconfig\_aws\_authenticator\_additional\_args](#input\_kubeconfig\_aws\_authenticator\_additional\_args) | n/a | `list(string)` | `[]` | no |
| <a name="input_kubeconfig_aws_authenticator_command"></a> [kubeconfig\_aws\_authenticator\_command](#input\_kubeconfig\_aws\_authenticator\_command) | n/a | `string` | `"aws-iam-authenticator"` | no |
| <a name="input_kubeconfig_aws_authenticator_command_args"></a> [kubeconfig\_aws\_authenticator\_command\_args](#input\_kubeconfig\_aws\_authenticator\_command\_args) | n/a | `list(string)` | `[]` | no |
| <a name="input_kubeconfig_aws_authenticator_env_variables"></a> [kubeconfig\_aws\_authenticator\_env\_variables](#input\_kubeconfig\_aws\_authenticator\_env\_variables) | n/a | `map(string)` | `{}` | no |
| <a name="input_kubeconfig_file_permission"></a> [kubeconfig\_file\_permission](#input\_kubeconfig\_file\_permission) | n/a | `string` | `"0600"` | no |
| <a name="input_kubeconfig_name"></a> [kubeconfig\_name](#input\_kubeconfig\_name) | n/a | `string` | `""` | no |
| <a name="input_kubeconfig_output_path"></a> [kubeconfig\_output\_path](#input\_kubeconfig\_output\_path) | n/a | `string` | `"./"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | <pre>object({<br><br>    sociedad             = string<br>    direccion_demandante = string<br>    unidad_pagadora      = string<br>    programa             = string<br>    proveedor            = string<br>    servicio             = string<br>    aplicacion           = string<br>    entorno              = string<br>    nombre               = string<br>    calendario           = string<br>    mantenimiento        = string<br>    iac                  = bool<br>    automatizacion       = bool<br>    confidencialidad     = string<br>    normativa            = string<br><br>  })</pre> | n/a | yes |
| <a name="input_license_model"></a> [license\_model](#input\_license\_model) | n/a | `string` | `"bring-your-own-license"` | no |
| <a name="input_local_secondary_indexes"></a> [local\_secondary\_indexes](#input\_local\_secondary\_indexes) | n/a | `any` | `[]` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | n/a | `string` | `null` | no |
| <a name="input_manage_aws_auth"></a> [manage\_aws\_auth](#input\_manage\_aws\_auth) | n/a | `bool` | `true` | no |
| <a name="input_manage_cluster_iam_resources"></a> [manage\_cluster\_iam\_resources](#input\_manage\_cluster\_iam\_resources) | n/a | `bool` | `false` | no |
| <a name="input_manage_worker_iam_resources"></a> [manage\_worker\_iam\_resources](#input\_manage\_worker\_iam\_resources) | n/a | `bool` | `true` | no |
| <a name="input_map_accounts"></a> [map\_accounts](#input\_map\_accounts) | n/a | `list(string)` | `null` | no |
| <a name="input_map_roles"></a> [map\_roles](#input\_map\_roles) | n/a | <pre>list(object({<br>    rolearn  = string<br>    username = string<br>  groups = list(string) }))</pre> | `[]` | no |
| <a name="input_map_users"></a> [map\_users](#input\_map\_users) | n/a | <pre>list(object({<br>    userarn  = string<br>    username = string<br>  groups = list(string) }))</pre> | `null` | no |
| <a name="input_master_password"></a> [master\_password](#input\_master\_password) | n/a | `string` | `""` | no |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | n/a | `string` | `"root"` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | n/a | `number` | `null` | no |
| <a name="input_monitoring_role_arn"></a> [monitoring\_role\_arn](#input\_monitoring\_role\_arn) | n/a | `string` | `""` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | n/a | `bool` | `null` | no |
| <a name="input_nivel_servicio"></a> [nivel\_servicio](#input\_nivel\_servicio) | Nivel de servicio de la arquitectura. Los valores admitidos son plata, oro y platino | `string` | n/a | yes |
| <a name="input_node_groups"></a> [node\_groups](#input\_node\_groups) | n/a | `any` | `null` | no |
| <a name="input_node_groups_defaults"></a> [node\_groups\_defaults](#input\_node\_groups\_defaults) | n/a | `any` | `{}` | no |
| <a name="input_openid_connect_audiences"></a> [openid\_connect\_audiences](#input\_openid\_connect\_audiences) | n/a | `list(string)` | `[]` | no |
| <a name="input_option_group_description"></a> [option\_group\_description](#input\_option\_group\_description) | n/a | `string` | `""` | no |
| <a name="input_option_group_name"></a> [option\_group\_name](#input\_option\_group\_name) | n/a | `string` | `null` | no |
| <a name="input_option_group_timeouts"></a> [option\_group\_timeouts](#input\_option\_group\_timeouts) | n/a | `map(string)` | <pre>{<br>  "delete": "15m"<br>}</pre> | no |
| <a name="input_option_group_use_name_prefix"></a> [option\_group\_use\_name\_prefix](#input\_option\_group\_use\_name\_prefix) | n/a | `bool` | `false` | no |
| <a name="input_options"></a> [options](#input\_options) | n/a | `any` | `{}` | no |
| <a name="input_parameter_group_description"></a> [parameter\_group\_description](#input\_parameter\_group\_description) | n/a | `string` | `""` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | n/a | `string` | `null` | no |
| <a name="input_parameter_group_use_name_prefix"></a> [parameter\_group\_use\_name\_prefix](#input\_parameter\_group\_use\_name\_prefix) | n/a | `bool` | `false` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | n/a | `list(map(string))` | `null` | no |
| <a name="input_password"></a> [password](#input\_password) | n/a | `string` | `""` | no |
| <a name="input_performance_insights_kms_key_id"></a> [performance\_insights\_kms\_key\_id](#input\_performance\_insights\_kms\_key\_id) | n/a | `string` | `null` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | n/a | `string` | `null` | no |
| <a name="input_point_in_time_recovery_enabled"></a> [point\_in\_time\_recovery\_enabled](#input\_point\_in\_time\_recovery\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_port"></a> [port](#input\_port) | n/a | `string` | `"1599"` | no |
| <a name="input_predefined_metric_type"></a> [predefined\_metric\_type](#input\_predefined\_metric\_type) | n/a | `string` | `"RDSReaderAverageCPUUtilization"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefijo para la construcción de los nombres de los recursos. | `string` | `"enagas"` | no |
| <a name="input_project"></a> [project](#input\_project) | Proyecto al que pertenecen los recursos | `string` | n/a | yes |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | n/a | `bool` | `false` | no |
| <a name="input_random_password_length"></a> [random\_password\_length](#input\_random\_password\_length) | n/a | `number` | `10` | no |
| <a name="input_range_key"></a> [range\_key](#input\_range\_key) | n/a | `string` | `""` | no |
| <a name="input_read_capacity"></a> [read\_capacity](#input\_read\_capacity) | n/a | `number` | `null` | no |
| <a name="input_replica_regions"></a> [replica\_regions](#input\_replica\_regions) | n/a | `any` | `[]` | no |
| <a name="input_replicate_source_db"></a> [replicate\_source\_db](#input\_replicate\_source\_db) | n/a | `string` | `null` | no |
| <a name="input_replication_source_identifier"></a> [replication\_source\_identifier](#input\_replication\_source\_identifier) | n/a | `string` | `null` | no |
| <a name="input_restore_to_point_in_time"></a> [restore\_to\_point\_in\_time](#input\_restore\_to\_point\_in\_time) | n/a | `map(string)` | `null` | no |
| <a name="input_s3_import"></a> [s3\_import](#input\_s3\_import) | n/a | `map(string)` | `null` | no |
| <a name="input_scaling_configuration"></a> [scaling\_configuration](#input\_scaling\_configuration) | n/a | `map(string)` | `{}` | no |
| <a name="input_security_group_egress_rules"></a> [security\_group\_egress\_rules](#input\_security\_group\_egress\_rules) | n/a | `map(any)` | `{}` | no |
| <a name="input_server_side_encryption_enabled"></a> [server\_side\_encryption\_enabled](#input\_server\_side\_encryption\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_server_side_encryption_kms_key_arn"></a> [server\_side\_encryption\_kms\_key\_arn](#input\_server\_side\_encryption\_kms\_key\_arn) | n/a | `string` | `""` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | n/a | `bool` | `true` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | n/a | `string` | `null` | no |
| <a name="input_source_region"></a> [source\_region](#input\_source\_region) | n/a | `string` | `"eu-west-1"` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | n/a | `bool` | `true` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | n/a | `string` | `"gp2"` | no |
| <a name="input_stream_enabled"></a> [stream\_enabled](#input\_stream\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_stream_view_type"></a> [stream\_view\_type](#input\_stream\_view\_type) | n/a | `string` | `null` | no |
| <a name="input_table_name"></a> [table\_name](#input\_table\_name) | n/a | `string` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | n/a | `map(string)` | `null` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | n/a | `string` | `""` | no |
| <a name="input_ttl_attribute_name"></a> [ttl\_attribute\_name](#input\_ttl\_attribute\_name) | n/a | `string` | `""` | no |
| <a name="input_ttl_enabled"></a> [ttl\_enabled](#input\_ttl\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_username"></a> [username](#input\_username) | n/a | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | `null` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_wait_for_cluster_timeout"></a> [wait\_for\_cluster\_timeout](#input\_wait\_for\_cluster\_timeout) | n/a | `number` | `300` | no |
| <a name="input_worker_additional_security_group_ids"></a> [worker\_additional\_security\_group\_ids](#input\_worker\_additional\_security\_group\_ids) | n/a | `list(string)` | `null` | no |
| <a name="input_worker_ami_name_filter"></a> [worker\_ami\_name\_filter](#input\_worker\_ami\_name\_filter) | n/a | `string` | `null` | no |
| <a name="input_worker_ami_name_filter_windows"></a> [worker\_ami\_name\_filter\_windows](#input\_worker\_ami\_name\_filter\_windows) | n/a | `string` | `null` | no |
| <a name="input_worker_ami_owner_id"></a> [worker\_ami\_owner\_id](#input\_worker\_ami\_owner\_id) | n/a | `string` | `null` | no |
| <a name="input_worker_ami_owner_id_windows"></a> [worker\_ami\_owner\_id\_windows](#input\_worker\_ami\_owner\_id\_windows) | n/a | `string` | `null` | no |
| <a name="input_worker_create_cluster_primary_security_group_rules"></a> [worker\_create\_cluster\_primary\_security\_group\_rules](#input\_worker\_create\_cluster\_primary\_security\_group\_rules) | n/a | `bool` | `false` | no |
| <a name="input_worker_create_initial_lifecycle_hooks"></a> [worker\_create\_initial\_lifecycle\_hooks](#input\_worker\_create\_initial\_lifecycle\_hooks) | n/a | `bool` | `null` | no |
| <a name="input_worker_create_security_group"></a> [worker\_create\_security\_group](#input\_worker\_create\_security\_group) | n/a | `bool` | `false` | no |
| <a name="input_worker_groups"></a> [worker\_groups](#input\_worker\_groups) | n/a | `list(any)` | `[]` | no |
| <a name="input_worker_groups_launch_template"></a> [worker\_groups\_launch\_template](#input\_worker\_groups\_launch\_template) | n/a | `list(any)` | `[]` | no |
| <a name="input_worker_security_group_id"></a> [worker\_security\_group\_id](#input\_worker\_security\_group\_id) | n/a | `string` | `null` | no |
| <a name="input_worker_sg_ingress_from_port"></a> [worker\_sg\_ingress\_from\_port](#input\_worker\_sg\_ingress\_from\_port) | n/a | `number` | `null` | no |
| <a name="input_workers_additional_policies"></a> [workers\_additional\_policies](#input\_workers\_additional\_policies) | n/a | `list(string)` | `[]` | no |
| <a name="input_workers_egress_cidrs"></a> [workers\_egress\_cidrs](#input\_workers\_egress\_cidrs) | n/a | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_workers_group_defaults"></a> [workers\_group\_defaults](#input\_workers\_group\_defaults) | n/a | `any` | `{}` | no |
| <a name="input_workers_role_name"></a> [workers\_role\_name](#input\_workers\_role\_name) | n/a | `string` | `null` | no |
| <a name="input_write_capacity"></a> [write\_capacity](#input\_write\_capacity) | n/a | `number` | `null` | no |
| <a name="input_write_kubeconfig"></a> [write\_kubeconfig](#input\_write\_kubeconfig) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_log_group_arn"></a> [cloudwatch\_log\_group\_arn](#output\_cloudwatch\_log\_group\_arn) | n/a |
| <a name="output_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#output\_cloudwatch\_log\_group\_name) | n/a |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | n/a |
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | n/a |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | n/a |
| <a name="output_cluster_iam_role_arn"></a> [cluster\_iam\_role\_arn](#output\_cluster\_iam\_role\_arn) | n/a |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | n/a |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | n/a |
| <a name="output_cluster_primary_security_group_id"></a> [cluster\_primary\_security\_group\_id](#output\_cluster\_primary\_security\_group\_id) | n/a |
| <a name="output_cluster_security_group_id"></a> [cluster\_security\_group\_id](#output\_cluster\_security\_group\_id) | n/a |
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | n/a |
| <a name="output_config_map_aws_auth"></a> [config\_map\_aws\_auth](#output\_config\_map\_aws\_auth) | n/a |
| <a name="output_database"></a> [database](#output\_database) | n/a |
| <a name="output_db_instance_address"></a> [db\_instance\_address](#output\_db\_instance\_address) | n/a |
| <a name="output_db_instance_arn"></a> [db\_instance\_arn](#output\_db\_instance\_arn) | n/a |
| <a name="output_db_instance_availability_zone"></a> [db\_instance\_availability\_zone](#output\_db\_instance\_availability\_zone) | n/a |
| <a name="output_db_instance_ca_cert_identifier"></a> [db\_instance\_ca\_cert\_identifier](#output\_db\_instance\_ca\_cert\_identifier) | n/a |
| <a name="output_db_instance_domain"></a> [db\_instance\_domain](#output\_db\_instance\_domain) | n/a |
| <a name="output_db_instance_domain_iam_role_name"></a> [db\_instance\_domain\_iam\_role\_name](#output\_db\_instance\_domain\_iam\_role\_name) | n/a |
| <a name="output_db_instance_endpoint"></a> [db\_instance\_endpoint](#output\_db\_instance\_endpoint) | n/a |
| <a name="output_db_instance_hosted_zone_id"></a> [db\_instance\_hosted\_zone\_id](#output\_db\_instance\_hosted\_zone\_id) | n/a |
| <a name="output_db_instance_id"></a> [db\_instance\_id](#output\_db\_instance\_id) | n/a |
| <a name="output_db_instance_name"></a> [db\_instance\_name](#output\_db\_instance\_name) | n/a |
| <a name="output_db_instance_password"></a> [db\_instance\_password](#output\_db\_instance\_password) | n/a |
| <a name="output_db_instance_port"></a> [db\_instance\_port](#output\_db\_instance\_port) | n/a |
| <a name="output_db_instance_resource_id"></a> [db\_instance\_resource\_id](#output\_db\_instance\_resource\_id) | n/a |
| <a name="output_db_instance_status"></a> [db\_instance\_status](#output\_db\_instance\_status) | n/a |
| <a name="output_db_instance_username"></a> [db\_instance\_username](#output\_db\_instance\_username) | n/a |
| <a name="output_db_master_password"></a> [db\_master\_password](#output\_db\_master\_password) | n/a |
| <a name="output_db_option_group_arn"></a> [db\_option\_group\_arn](#output\_db\_option\_group\_arn) | n/a |
| <a name="output_db_option_group_id"></a> [db\_option\_group\_id](#output\_db\_option\_group\_id) | n/a |
| <a name="output_db_parameter_group_arn"></a> [db\_parameter\_group\_arn](#output\_db\_parameter\_group\_arn) | n/a |
| <a name="output_db_parameter_group_id"></a> [db\_parameter\_group\_id](#output\_db\_parameter\_group\_id) | n/a |
| <a name="output_db_subnet_group_arn"></a> [db\_subnet\_group\_arn](#output\_db\_subnet\_group\_arn) | n/a |
| <a name="output_db_subnet_group_id"></a> [db\_subnet\_group\_id](#output\_db\_subnet\_group\_id) | n/a |
| <a name="output_eks"></a> [eks](#output\_eks) | n/a |
| <a name="output_enhanced_monitoring_iam_role_arn"></a> [enhanced\_monitoring\_iam\_role\_arn](#output\_enhanced\_monitoring\_iam\_role\_arn) | n/a |
| <a name="output_enhanced_monitoring_iam_role_name"></a> [enhanced\_monitoring\_iam\_role\_name](#output\_enhanced\_monitoring\_iam\_role\_name) | n/a |
| <a name="output_fargate_iam_role_arn"></a> [fargate\_iam\_role\_arn](#output\_fargate\_iam\_role\_arn) | n/a |
| <a name="output_fargate_iam_role_name"></a> [fargate\_iam\_role\_name](#output\_fargate\_iam\_role\_name) | n/a |
| <a name="output_fargate_profile_arns"></a> [fargate\_profile\_arns](#output\_fargate\_profile\_arns) | n/a |
| <a name="output_fargate_profile_ids"></a> [fargate\_profile\_ids](#output\_fargate\_profile\_ids) | n/a |
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | n/a |
| <a name="output_kubeconfig_filename"></a> [kubeconfig\_filename](#output\_kubeconfig\_filename) | n/a |
| <a name="output_node_groups"></a> [node\_groups](#output\_node\_groups) | n/a |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | n/a |
| <a name="output_security_group_rule_cluster_https_worker_ingress"></a> [security\_group\_rule\_cluster\_https\_worker\_ingress](#output\_security\_group\_rule\_cluster\_https\_worker\_ingress) | n/a |

<!--- END_TF_DOCS --->

