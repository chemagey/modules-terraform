#############################################################
###                     VARIABLES RDS                     ###
#############################################################

variable "nivel_servicio" {
  type        = string
  description = "Nivel de servicio de la arquitectura. Los valores admitidos son plata, oro y platino"

  validation {
    condition     = contains(["platino", "oro", "plata"], var.nivel_servicio)
    error_message = "The service level must be plata, oro o platinvar.labels."
  }
}

variable "environment" {
  type        = string
  description = "Entorno en el que se se vana  desplegar los recursos. Los valores deben ser dev, pre y pro"
  validation {
    condition     = contains(["dev", "pre", "pro"], var.environment)
    error_message = "The environment must comply with the following values : [dev, pre, pro] ."
  }
}


variable "project" {
  type        = string
  description = "Proyecto al que pertenecen los recursos"

  validation {
    condition     = can(regex("(\\w+)", var.project))
    error_message = "The prefix must comply with the following format : ."
  }
}

variable "db_type" {
  type        = string
  description = "Tipo de base de datos que se desea desplegar, aurora, oracle, dynamo o postge. Si se deja sin especificar no se crea base de datos"
  default     = ""
  validation {
    condition     = contains(["oracle", "postgre", "dynamo", "aurora", ""], var.db_type)
    error_message = "All bad :( ."
  }

}


variable "create_eks" {
  type        = bool
  description = "Crear o no un cluster de eks. "
  default     = true
}

variable "prefix" {
  type        = string
  description = "Prefijo para la construcción de los nombres de los recursos. "
  default     = "enagas"
  validation {
    condition     = can(regex("([A-Za-z]+)", var.prefix))
    error_message = "The prefix must comply with the following format : ."
  }
}


variable "identifier" {
  type        = string
  description = "Identificador de la base de datos RDS."
  default     = null
  validation {
    condition     = can(regex("(\\w+)", var.identifier)) || var.identifier == null
    error_message = "The identifier must comply with the following format : enagas-<proyecto>-pre/pro/dev-rds ."
  }
}

# variable "engine" {
#   type        = string
#   description = "Motor de base de datos"
#   default     = ""
#   validation {
#     condition     = contains(["oracle", "postgresql", ""], var.engine)
#     error_message = "The databse engine must be oracle or postgresql."
#   }
# }

variable "database_name" {
  type        = string
  description = "Nombre de la base de datos"
  default     = null
  validation {
    condition     = can(regex("(\\w+)", var.database_name)) || var.database_name == null
    error_message = "The database_name must comply with the following format : [a-zA-Z0-9_]."
  }
}

variable "allocated_storage" {
  type        = number
  description = "Tamaño de la base de datos"
  default     = null
}
# variable "engine_version" {
#   type        = string
#   description = ""

#   validation {
#     condition     = contains(["19.0.0.0.ru-2021-01.rur-2021-07.r1", "PostgreSQL.13.4.R1"], var.engine_version)
#     error_message = "The engine version must be 19.0.0.0.ru-2021-01.rur-2021-07.r1"
#   }
# }

variable "instance_class" {
  type        = string
  description = "Tipos de instancia utilizada para las instancias de base de datos"
  default     = ""
  validation {
    condition     = contains(["db.t3.medium", "db.t3.large", "db.t3.xlarge", "db.t3.2xlarge", "db.m5.large", "db.m5.xlarge", "db.m5.2xlarge", "db.r5.large", "db.r5.xlarge", "db.r5.2xlarge", "db.r5.4xlarge", "db.r5.8xlarge", "db.m5.large", "db.m5.xlarge", "db.m5.2xlarge", "db.m5.4xlarge", "db.m5.8xlarge", ""], var.instance_class)
    error_message = "The instance class must be one of the next values: plata -> [db.t3.medium, db.t3.large, db.t3.xlarge, db.t3.2xlarge, db.m5.large, db.m5.xlarge, db.m5.2xlarge] | oro/platino -> [db.r5.large, db.r5.xlarge, db.r5.2xlarge, db.r5.4xlarge, db.r5.8xlarge, db.m5.large, db.m5.xlarge, db.m5.2xlarge, db.m5.4xlarge, db.m5.8xlarge]."
  }
}



variable "maintenance_window" {
  type        = string
  description = ""
  default     = null
}
variable "backup_window" {
  type        = string
  description = ""
  default     = null
}

variable "monitoring_interval" {
  type        = number
  description = ""
  default     = null
}
variable "monitoring_role_arn" {
  type        = string
  description = ""
  default     = ""
  validation {
    condition     = can(regex("arn:aws:iam::([0-9]+):role/enagas-([A-Za-z]+)-(pre|pro|dev)-([A-Za-z]+)", var.monitoring_role_arn)) || var.monitoring_role_arn == ""
    error_message = "The monitoring role arn must comply with the following format: arn:aws:iam::<num_cuenta>:role/enagas-<proyecto>-pre/pro/dev-rdsmon."
  }
}

variable "availability_zone" {
  type        = string
  description = ""
  default     = "eu-west-1a"
}

variable "ca_cert_identifier" {
  type        = string
  description = ""
  default     = "rds-ca-2019"
}

variable "backup_retention_period" {
  type        = number
  description = ""
  default     = 30
}
variable "vpc_security_group_ids" {
  type        = list(string)
  description = ""
  default     = []
}
variable "allow_major_version_upgrade" {
  type        = bool
  description = ""
  default     = false
}

variable "apply_immediately" {
  type        = bool
  description = ""
  default     = false
}
variable "auto_minor_version_upgrade" {
  type        = bool
  description = ""
  default     = false
}

variable "copy_tags_to_snapshot" {
  type        = bool
  description = ""
  default     = true
}
variable "create_db_instance" {
  type        = bool
  description = ""
  default     = true
}
variable "create_db_option_group" {
  type        = bool
  description = ""
  default     = true
}
variable "create_db_parameter_group" {
  type        = bool
  description = ""
  default     = true
}
variable "create_db_subnet_group" {
  type        = bool
  description = ""
  default     = true
}
variable "create_monitoring_role" {
  type        = bool
  description = ""
  default     = false
}
variable "create_random_password" {
  type        = bool
  description = ""
  default     = false
}
variable "cross_region_replica" {
  type        = bool
  description = ""
  default     = false
}
variable "db_subnet_group_use_name_prefix" {
  type        = bool
  description = ""
  default     = false
}
variable "delete_automated_backups" {
  type        = bool
  description = ""
  default     = true
}
variable "deletion_protection" {
  type        = bool
  description = ""
  default     = false
}

variable "option_group_use_name_prefix" {
  type        = bool
  description = ""
  default     = false
}
variable "parameter_group_use_name_prefix" {
  type        = bool
  description = ""
  default     = false
}

variable "publicly_accessible" {
  type        = bool
  description = ""
  default     = false
}

variable "skip_final_snapshot" {
  type        = bool
  description = ""
  default     = true
}

variable "storage_encrypted" {
  type        = bool
  description = ""
  default     = true
}

variable "random_password_length" {
  type        = number
  description = ""
  default     = 10
}
variable "options" {
  type        = any
  description = ""
  default     = {}
}

variable "multi_az" {
  type        = bool
  description = ""
  default     = null
}
variable "db_subnet_group_description" {
  type        = string
  description = ""
  default     = ""
}

variable "option_group_description" {
  type        = string
  description = ""
  default     = ""
}
variable "parameter_group_description" {
  type        = string
  description = ""
  default     = ""
}
variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = ""
  default     = null
}

variable "db_subnet_ids" {
  type        = list(string)
  description = ""
  default     = []
}
variable "option_group_timeouts" {
  type        = map(string)
  description = ""
  default     = { "delete" : "15m" }
}

variable "timeouts" {
  type        = map(string)
  description = ""
  default     = null
}


variable "iops" {
  type        = number
  description = ""
  default     = 0
}
variable "username" {
  type        = string
  description = ""
  default     = null
}

variable "password" {
  type        = string
  description = ""
  default     = ""
}

variable "port" {
  type        = string
  description = ""
  default     = "1599"
  validation {
    condition     = contains(["1599", "5542"], var.port)
    error_message = "Port must be 1599 or 5542."
  }
}


variable "parameters" {
  type        = list(map(string))
  description = ""
  default     = null
}

variable "character_set_name" {
  type        = string
  description = ""
  default     = "UTF8"
  validation {
    condition     = contains(["AL32UTF8", "UTF8"], var.character_set_name)
    error_message = "Charset must be AL32UTF8 or UTF8."
  }

}

variable "db_subnet_group_name" {
  type        = string
  description = ""
  default     = null
  validation {
    condition     = can(regex("(\\w+)", var.db_subnet_group_name)) || var.db_subnet_group_name == null
    error_message = "Subnet group name must comply with the following format: [a-zA-Z0-9_] ."
  }
}

variable "domain" {
  type        = string
  description = ""

  validation {
    condition     = contains(["ENAGAS", "ENAPRE", "ENADES", ""], var.domain)
    error_message = "Domain must be ENAGAS, ENAPRE or ENADES."
  }
  default = ""
}

variable "domain_iam_role_name" {
  type        = string
  description = ""
  default     = null

  validation {
    condition     = can(regex("enagas-([A-Za-z]+)-(pro|pre|dev)-rdsoracle", var.domain_iam_role_name)) || var.domain_iam_role_name == null
    error_message = "Domain iam role name must comply with the following format: enagas-<proyecto>-dev/pre/pro-rdsoracle."
  }
}


variable "kms_key_id" {
  type        = string
  description = ""
  default     = null
  validation {
    condition     = can(regex("arn:aws:kms:eu-west-1:([0-9]+):key/\\w{8}-\\w{4}-\\w{4}-\\w{4}-\\w{12}", var.kms_key_id)) || var.kms_key_id == null
    error_message = "Kms key must be managed by aws."
  }
}

variable "license_model" {
  type        = string
  description = ""
  default     = "bring-your-own-license"
  validation {
    condition     = contains(["bring-your-own-license", "license-included"], var.license_model)
    error_message = "License model must be bring-your-own-license o license-included."
  }
}

variable "option_group_name" {
  type        = string
  description = ""
  default     = null
  validation {
    condition     = can(regex("(\\w+)", var.option_group_name)) || var.option_group_name == null
    error_message = "Option group name must comply with the following format: [a-zA-Z0-9_] ."
  }
}

variable "parameter_group_name" {
  type        = string
  description = ""
  default     = null
  validation {
    condition     = can(regex("(\\w+)", var.parameter_group_name)) || var.parameter_group_name == null
    error_message = "Parameter group name must comply with the following format: [a-zA-Z0-9_] ."
  }
}

variable "performance_insights_kms_key_id" {
  type        = string
  description = ""
  default     = null
  validation {
    condition     = can(regex("arn:aws:kms:eu-west-1:([0-9]+):key/\\w{8}-\\w{4}-\\w{4}-\\w{4}-\\w{12}", var.performance_insights_kms_key_id)) || var.performance_insights_kms_key_id == null
    error_message = "Performance insight kms key id must be managed by aws."
  }

}

variable "replicate_source_db" {
  type        = string
  description = ""
  default     = null
}

variable "restore_to_point_in_time" {
  type        = map(string)
  description = ""
  default     = null
}

variable "snapshot_identifier" {
  type        = string
  description = ""
  default     = null
}

variable "storage_type" {
  type        = string
  description = ""
  default     = "gp2"
  validation {
    condition     = contains(["Io1", "gp2"], var.storage_type)
    error_message = "Storage type must be Io1 or gp2."
  }
}

variable "timezone" {
  type        = string
  description = ""
  default     = ""
}

variable "s3_import" {
  type        = map(string)
  description = ""
  default     = null
}

variable "labels" {
  type = object({

    sociedad             = string
    direccion_demandante = string
    unidad_pagadora      = string
    programa             = string
    proveedor            = string
    servicio             = string
    aplicacion           = string
    entorno              = string
    nombre               = string
    calendario           = string
    mantenimiento        = string
    iac                  = bool
    automatizacion       = bool
    confidencialidad     = string
    normativa            = string

  })

  description = ""
  validation {
    # cambiar !contains([ por 
    condition     = contains(["sa", "gts", "transporte"], var.labels.sociedad)
    error_message = "Valor de sociedad incorrecto, tiene que ser uno de los siguientes, [sa, gts, transporte]."
  }
  validation {
    condition     = length(var.labels.direccion_demandante) < 64 && can(regex("^(dgral_|d_)[a-z]+[a-z0-9_]*$", var.labels.direccion_demandante))
    error_message = "Formato incorrecto, la variable debe de tener una longitud menor a 64 caracteres y emepezar por d_ o dgral_ seguido de un identificador."
  }
  validation {
    condition     = length(var.labels.unidad_pagadora) < 64 && can(regex("^(dgral_|d_|g_)[a-z]+[a-z0-9_]*$", var.labels.unidad_pagadora))
    error_message = "Formato incorrecto, la variable debe de tener una longitud menor a 64 caracteres y emepezar por d_ , dgral_ o g_ , seguido de un identificador."
  }
  validation {
    condition     = length(var.labels.programa) < 64 && can(regex("^[a-z]+[a-z0-9_]*$", var.labels.programa))
    error_message = "Formato incorrecto, la variable debe de empezar por una letra, seguida de 0 a n letras o numeros o _."
  }
  validation {
    condition     = length(var.labels.proveedor) < 64 && can(regex("^[a-z]+[a-z0-9_]*$", var.labels.proveedor))
    error_message = "Formato incorrecto, la variable debe de empezar por una letra, seguida de 0 a n letras o numeros o _."
  }
  validation {
    condition     = length(var.labels.servicio) < 64 && can(regex("^[a-z]+[a-z0-9_]*$", var.labels.servicio))
    error_message = "Formato incorrecto, la variable debe de empezar por una letra, seguida de 0 a n letras o numeros o _."
  }
  validation {
    condition     = length(var.labels.aplicacion) < 64 && can(regex("^[a-z]+[a-z0-9_]*$", var.labels.aplicacion))
    error_message = "Formato incorrecto, la variable debe de empezar por una letra, seguida de 0 a n letras o numeros o _."
  }
  validation {
    condition     = contains(["prod", "int", "pre", "des"], var.labels.entorno)
    error_message = "Valor de entorno incorrecto, tiene que ser uno de los siguientes, [prod, int, pre, des]."
  }
  validation {
    condition     = length(var.labels.nombre) < 64 && can(regex("^[a-z]+[a-z0-9_]*$", var.labels.nombre))
    error_message = "Formato incorrecto, la variable debe de empezar por una letra, seguida de 0 a n letras o numeros o _."
  }
  validation {
    condition     = contains(["critico", "alto", "medio", "bajo"], var.labels.confidencialidad)
    error_message = "Valor de confidencialidad incorrecto, tiene que ser uno de los siguientes, [critico, alto, medio, bajo]."
  }
  validation {
    condition     = length(var.labels.normativa) < 64 && can(regex("^[a-z]+[a-z0-9_]*$", var.labels.normativa))
    error_message = "Formato incorrecto, la variable debe de empezar por una letra, seguida de 0 a n letras o numeros o _."
  }
}
#############################################################
###                     VARIABLES EKS                     ###
#############################################################
variable "eks_name" {
  type        = string
  description = ""
  default     = null
  validation {
    condition     = can(regex("(\\w+)", var.eks_name)) || var.eks_name == null
    error_message = "The identifier must comply with the following format : [a-zA-Z0-9_]."
  }

}
variable "cluster_version" {
  type        = string
  description = ""
  default     = null
}

variable "vpc_id" {
  type        = string
  description = ""
  default     = null
}

variable "eks_subnets" {
  type        = list(string)
  description = ""
  default     = null
}
variable "cluster_endpoint_private_access" {
  type        = bool
  description = ""
  default     = true
}

variable "cluster_endpoint_public_access" {
  type        = bool
  description = ""
  default     = false
}
variable "cluster_endpoint_private_access_cidrs" {
  type        = list(string)
  description = ""
  default     = ["10.140.0.0/16", "10.141.0.0/16"]
}

variable "cluster_endpoint_private_access_sg" {
  type        = list(string)
  description = ""
  default     = []
}
variable "cluster_endpoint_public_access_cidrs" {
  type        = list(string)
  description = ""
  default     = []
}
variable "cluster_delete_timeout" {
  type        = string
  description = ""
  default     = "15m"
}
variable "cluster_create_timeout" {
  type        = string
  description = ""
  default     = "30m"
}

variable "cluster_update_timeout" {
  type        = string
  description = ""
  default     = "60m"
}
variable "cluster_egress_cidrs" {
  type        = list(string)
  description = ""
  default     = ["0.0.0.0/0"]
}
variable "cluster_enabled_log_types" {
  type        = list(string)
  description = ""
  default     = ["api", "audit"]
}

variable "cluster_log_retention_in_days" {
  type        = number
  description = ""
  default     = null
}

variable "wait_for_cluster_timeout" {
  type        = number
  description = ""
  default     = 300
}

variable "cluster_service_ipv4_cidr" {
  type        = string
  description = ""
  default     = null
}

variable "fargate_pod_execution_role_name" {
  type        = string
  description = ""
  default     = null
}

variable "permissions_boundary" {
  type        = string
  description = ""
  default     = null
}

variable "iam_path" {
  type        = string
  description = ""
  default     = "/eks/"
}
variable "workers_egress_cidrs" {
  type        = list(string)
  description = ""
  default     = ["0.0.0.0/0"]
}
variable "attach_worker_cni_policy" {
  type        = bool
  description = ""
  default     = true
}

variable "cluster_create_endpoint_private_access_sg_rule" {
  type        = bool
  description = ""
  default     = false
}
variable "write_kubeconfig" {
  type        = bool
  description = ""
  default     = false
}
variable "cluster_create_security_group" {
  type        = bool
  description = ""
  default     = false
}
variable "create_eks_resources" {
  type        = bool
  description = ""
  default     = true
}

variable "create_fargate_pod_execution_role" {
  type        = bool
  description = ""
  default     = false
}
variable "enable_irsa" {
  type        = bool
  description = ""
  default     = false
}
variable "manage_aws_auth" {
  type        = bool
  description = ""
  default     = true
}
variable "manage_cluster_iam_resources" {
  type        = bool
  description = ""
  default     = false
}

variable "manage_worker_iam_resources" {
  type        = bool
  description = ""
  default     = true
}
variable "aws_auth_additional_labels" {
  type        = map(string)
  description = ""
  default     = null
}
variable "kubeconfig_aws_authenticator_command" {
  type        = string
  description = ""
  default     = "aws-iam-authenticator"
}
variable "default_platform" {
  type        = string
  description = ""
  default     = "linux"
}
variable "eks_oidc_root_ca_thumbprint" {
  type        = string
  description = ""
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}
variable "cluster_log_kms_key_id" {
  type        = string
  description = ""
  default     = null

  validation {
    condition     = can(regex("arn:aws:kms:eu-west-1:([0-9]+):key/\\w{8}-\\w{4}-\\w{4}-\\w{4}-\\w{12}", var.cluster_log_kms_key_id)) || var.cluster_log_kms_key_id == null
    error_message = "Cluster_log_kms_key_id key must be managed by aws."
  }
}


variable "cluster_security_group_id" {
  type        = string
  description = ""
  default     = null
}

variable "kubeconfig_aws_authenticator_command_args" {
  type        = list(string)
  description = ""
  default     = []
}
variable "kubeconfig_aws_authenticator_additional_args" {
  type        = list(string)
  description = ""
  default     = []
}
variable "kubeconfig_aws_authenticator_env_variables" {
  type        = map(string)
  description = ""
  default     = {}
}
variable "kubeconfig_file_permission" {
  type        = string
  description = ""
  default     = "0600"
}
variable "fargate_profiles" {
  type        = map(string)
  description = ""
  default     = {}
}

variable "fargate_subnets" {
  type        = list(string)
  description = ""
  default     = null
}
variable "kubeconfig_name" {
  type        = string
  description = ""
  default     = ""
}

variable "kubeconfig_output_path" {
  type        = string
  description = ""
  default     = "./"
}


variable "cluster_iam_role_name" {
  type        = string
  description = ""
  default     = null
}

variable "map_roles" {
  type = list(object({
    rolearn  = string
    username = string
  groups = list(string) }))
  description = ""
  default     = []
}
variable "map_accounts" {
  type        = list(string)
  description = ""
  default     = null
}
variable "map_users" {
  type = list(object({
    userarn  = string
    username = string
  groups = list(string) }))
  description = ""
  default     = null
}

variable "node_groups" {
  type        = any
  description = ""
  default     = null
}

variable "node_groups_defaults" {
  type        = any
  description = ""
  default     = {}
}

variable "openid_connect_audiences" {
  type        = list(string)
  description = ""
  default     = []
}
variable "worker_additional_security_group_ids" {
  type        = list(string)
  description = ""
  default     = null
}
variable "worker_ami_name_filter" {
  type        = string
  description = ""
  default     = null
}
variable "worker_ami_name_filter_windows" {
  type        = string
  description = ""
  default     = null
}

variable "worker_ami_owner_id" {
  type        = string
  description = ""
  default     = null
}
variable "worker_ami_owner_id_windows" {
  type        = string
  description = ""
  default     = null
}

variable "worker_create_cluster_primary_security_group_rules" {
  type        = bool
  description = ""
  default     = false
}
variable "worker_create_initial_lifecycle_hooks" {
  type        = bool
  description = ""
  default     = null
}
variable "worker_create_security_group" {
  type        = bool
  description = ""
  default     = false
}
variable "worker_security_group_id" {
  type        = string
  description = ""
  default     = null
}
variable "workers_additional_policies" {
  type        = list(string)
  description = ""
  default     = []
}
variable "worker_groups" {
  type        = list(any)
  description = ""
  default     = []
}
variable "worker_sg_ingress_from_port" {
  type        = number
  description = ""
  default     = null
}
variable "worker_groups_launch_template" {
  type        = list(any)
  description = ""
  default     = []
}
variable "workers_group_defaults" {
  type        = any
  description = ""
  default     = {}
}
variable "workers_role_name" {
  type        = string
  description = ""
  default     = null
}

#############################################################
###                     VARIABLES AURORA                  ###
#############################################################

variable "backtrack_window" {
  type        = number
  description = ""
  default     = 0
}

variable "db_cluster_db_instance_parameter_group_name" {
  type        = string
  description = ""
  default     = null
}

variable "db_cluster_parameter_group_name" {
  type        = string
  description = ""
  default     = null
}

variable "db_parameter_group_name" {
  type        = string
  description = ""
  default     = null
}

variable "enable_global_write_forwarding" {
  type        = bool
  description = ""
  default     = false
}

variable "enable_http_endpoint" {
  type        = bool
  description = ""
  default     = false
}

variable "global_cluster_identifier" {
  type        = string
  description = ""
  default     = null
}
variable "iam_database_authentication_enabled" {
  type        = bool
  description = ""
  default     = false
}
variable "iam_role_managed_policy_arns" {
  type        = list(string)
  description = ""
  default     = []
}
variable "iam_role_max_session_duration" {
  type        = number
  description = ""
  default     = 0 #300
}
variable "iam_role_name" {
  type        = string
  description = ""
  default     = null
}
variable "iam_role_path" {
  type        = string
  description = ""
  default     = "/"
}
variable "iam_role_permissions_boundary" {
  type        = string
  description = ""
  default     = ""
}
variable "master_password" {
  type        = string
  description = ""
  default     = ""
}
variable "replication_source_identifier" {
  type        = string
  description = ""
  default     = null
}
variable "source_region" {
  type        = string
  description = ""
  default     = "eu-west-1"
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = ""
  default     = []
}

variable "security_group_egress_rules" {
  type        = map(any)
  description = ""
  default     = {}
}
variable "autoscaling_enabled" {
  type        = bool
  description = ""
  default     = false
}
variable "autoscaling_max_capacity" {
  type        = number
  description = ""
  default     = 2
}
variable "autoscaling_min_capacity" {
  type        = number
  description = ""
  default     = 1
}
variable "autoscaling_scale_in_cooldown" {
  type        = number
  description = ""
  default     = 300
}
variable "autoscaling_scale_out_cooldown" {
  type        = number
  description = ""
  default     = 300
}
variable "autoscaling_target_connections" {
  type        = number
  description = ""
  default     = 700
}
variable "autoscaling_target_cpu" {
  type        = number
  description = ""
  default     = 70
}
variable "cluster_timeouts" {
  type        = map(string)
  description = ""
  default     = {}
}
variable "create_cluster" {
  type        = bool
  description = ""
  default     = true
}
variable "iam_role_use_name_prefix" {
  type        = bool
  description = ""
  default     = false
}
variable "instance_timeouts" {
  type        = map(string)
  description = ""
  default     = {}
}
variable "instances" {
  type        = any
  description = ""
  default     = { 1 = {} }
}
variable "instances_use_identifier_prefix" {
  type        = bool
  description = ""
  default     = false
}
variable "is_primary_cluster" {
  type        = bool
  description = ""
  default     = true
}
variable "master_username" {
  type        = string
  description = ""
  default     = "root"
}
variable "predefined_metric_type" {
  type        = string
  description = ""
  default     = "RDSReaderAverageCPUUtilization"
}
variable "scaling_configuration" {
  type        = map(string)
  description = ""
  default     = {}
}
variable "allowed_security_groups" {
  type        = list(string)
  description = ""
  default     = []
}
variable "create_security_group" {
  type        = bool
  description = ""
  default     = true
}
variable "final_snapshot_identifier_prefix" {
  type        = string
  description = ""
  default     = "final"
}
variable "iam_role_force_detach_policies" {
  type        = bool
  description = ""
  default     = false
}


#############################################################
###                     VARIABLES DYNAMO                  ###
#############################################################
variable "hash_key" {
  type        = string
  description = ""
  default     = "id"
  validation {
    condition     = contains(["id", "userid"], var.hash_key)
    error_message = "Hash key must be id or userid."
  }
}
variable "table_name" {
  type        = string
  description = ""
  default     = null
}
variable "range_key" {
  type        = string
  description = ""
  default     = ""
}
variable "read_capacity" {
  type        = number
  description = ""
  default     = null
}
variable "server_side_encryption_kms_key_arn" {
  type        = string
  description = ""
  default     = ""
}

variable "stream_view_type" {
  type        = string
  description = ""
  default     = null
}

variable "write_capacity" {
  type        = number
  description = ""
  default     = null
}

variable "attributes" {
  type        = list(map(string))
  description = ""
  default     = []
}

variable "autoscaling_defaults" {
  type        = map(string)
  description = ""
  default = {
    "scale_in_cooldown" : 0,
    "scale_out_cooldown" : 0,
    "target_value" : 70
  }
}


variable "autoscaling_indexes" {
  type        = map(map(string))
  description = ""
  default     = {}
}

variable "autoscaling_read" {
  type        = map(string)
  description = ""
  default     = {}
}

variable "autoscaling_write" {
  type        = map(string)
  description = ""
  default     = {}
}
variable "billing_mode" {
  type        = string
  description = ""
  default     = "PAY_PER_REQUEST"
}
variable "create_table" {
  type        = bool
  description = ""
  default     = true
}

variable "global_secondary_indexes" {
  type        = any
  description = ""
  default     = []
}

variable "local_secondary_indexes" {
  type        = any
  description = ""
  default     = []
}

variable "point_in_time_recovery_enabled" {
  type        = bool
  description = ""
  default     = false
}

variable "replica_regions" {
  type        = any
  description = ""
  default     = []
}


variable "server_side_encryption_enabled" {
  type        = bool
  description = ""
  default     = false
}


variable "stream_enabled" {
  type        = bool
  description = ""
  default     = false
}



variable "ttl_attribute_name" {
  type        = string
  description = ""
  default     = ""
}

variable "ttl_enabled" {
  type        = bool
  description = ""
  default     = false
}

variable "cluster_parameters" {
  type        = list(map(string))
  description = ""
  default     = null
}

variable "instance_parameters" {
  type        = list(map(string))
  description = ""
  default     = null
}
