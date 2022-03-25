module "rds" {
  count                   = (contains(["oracle", "postgre"], var.db_type) ? 1 : 0)
  source                  = "terraform-aws-modules/rds/aws"
  version                 = "~> 3.0"
  identifier              = var.identifier != null ? "${local.resource_name}-${var.identifier}" : "${local.resource_name}-rds"
  engine                  = var.db_type == "oracle" ? "oracle-ee" : "postgres"
  family                  = var.db_type == "oracle" ? "oracle-ee-19" : "postgres13"
  engine_version          = var.db_type == "oracle" ? "19.0.0.0.ru-2021-07.rur-2021-07.r1" : "13.4"
  major_engine_version    = local.config[var.db_type].major_engine_version
  instance_class          = local.config[var.nivel_servicio].instance_class
  availability_zone       = var.availability_zone
  allocated_storage       = var.allocated_storage
  name                    = var.database_name
  username                = var.username
  password                = var.password
  port                    = var.port
  backup_retention_period = var.backup_retention_period
  vpc_security_group_ids  = var.vpc_security_group_ids
  maintenance_window      = var.maintenance_window != null ? var.maintenance_window : local.config[var.nivel_servicio].maintenance_window
  backup_window           = var.backup_window != null ? var.backup_window : local.config[var.nivel_servicio].backup_window
  monitoring_interval     = var.monitoring_interval != null ? var.monitoring_interval : local.config[var.nivel_servicio].monitoring_interval

  monitoring_role_arn = var.monitoring_role_arn

  monitoring_role_description = "Terraform managed. IAM Monitoring ${var.db_type} RDS Role ${var.environment}"
  ca_cert_identifier          = var.ca_cert_identifier
  character_set_name          = var.db_type == "oracle" ? var.character_set_name : null
  db_subnet_group_name        = var.db_subnet_group_name != null ? "${local.resource_name}-${var.db_subnet_group_name}" : "${local.resource_name}-subnetgroup"
  domain                      = var.nivel_servicio == "plata" ? var.domain : "ENAGAS"
  domain_iam_role_name        = var.domain_iam_role_name
  final_snapshot_identifier   = var.identifier != null ? "${local.resource_name}-${var.identifier}-final-snapshot" : "${local.resource_name}-rds-final-snapshot "

  kms_key_id = var.kms_key_id

  license_model        = var.db_type == "oracle" ? var.license_model : "postgresql-license"
  option_group_name    = var.db_type == "oracle" ? (var.option_group_name != null ? "${local.resource_name}-rds-${var.option_group_name}" : "${local.resource_name}-rds-${var.db_type}") : null
  parameter_group_name = var.parameter_group_name != null ? "${local.resource_name}-rds-${var.parameter_group_name}" : "${local.resource_name}-rds-${var.db_type}"

  performance_insights_kms_key_id       = var.performance_insights_kms_key_id
  replicate_source_db                   = var.replicate_source_db
  restore_to_point_in_time              = var.restore_to_point_in_time != null ? var.restore_to_point_in_time : local.config[var.db_type].restore_to_point_in_time
  snapshot_identifier                   = var.snapshot_identifier
  storage_type                          = var.storage_type
  timezone                              = var.timezone
  s3_import                             = var.s3_import
  db_instance_tags                      = var.labels
  db_option_group_tags                  = var.labels
  db_subnet_group_tags                  = var.labels
  tags                                  = var.labels
  performance_insights_enabled          = local.config[var.nivel_servicio].performance_insights_enabled
  performance_insights_retention_period = local.config[var.nivel_servicio].performance_insights_retention_period
  parameters                            = var.parameters != null ? var.parameters : local.config[var.db_type].parameters
  allow_major_version_upgrade           = var.allow_major_version_upgrade
  apply_immediately                     = var.apply_immediately
  auto_minor_version_upgrade            = var.auto_minor_version_upgrade
  copy_tags_to_snapshot                 = var.copy_tags_to_snapshot
  create_db_instance                    = var.create_db_instance
  create_db_option_group                = var.db_type == "oracle" ? var.create_db_option_group : false
  create_db_parameter_group             = var.create_db_parameter_group
  create_db_subnet_group                = var.create_db_subnet_group
  create_monitoring_role                = var.create_monitoring_role
  create_random_password                = var.create_random_password
  cross_region_replica                  = var.cross_region_replica
  db_subnet_group_description           = var.db_subnet_group_description
  db_subnet_group_use_name_prefix       = var.db_subnet_group_use_name_prefix
  delete_automated_backups              = var.delete_automated_backups
  deletion_protection                   = var.deletion_protection
  enabled_cloudwatch_logs_exports       = var.enabled_cloudwatch_logs_exports != null ? var.enabled_cloudwatch_logs_exports : local.config[var.db_type].enabled_cloudwatch_logs_exports
  multi_az                              = var.multi_az != null ? var.multi_az : local.config[var.nivel_servicio].multi_az
  option_group_description              = var.option_group_description
  option_group_timeouts                 = var.option_group_timeouts
  option_group_use_name_prefix          = var.option_group_use_name_prefix
  options                               = var.options
  parameter_group_description           = var.parameter_group_description
  parameter_group_use_name_prefix       = var.parameter_group_use_name_prefix
  publicly_accessible                   = var.publicly_accessible
  random_password_length                = var.random_password_length
  skip_final_snapshot                   = var.skip_final_snapshot
  storage_encrypted                     = var.storage_encrypted
  subnet_ids                            = var.db_subnet_ids
  timeouts                              = var.timeouts != null ? var.timeouts : local.config[var.db_type].timeouts
  iops                                  = var.iops
}

module "dynamodb" {
  count  = var.db_type == "dynamo" ? 1 : 0
  source = "terraform-aws-modules/dynamodb-table/aws"

  create_table                       = true
  name                               = var.table_name != null ? "${local.resource_name}-${var.table_name}" : "${local.resource_name}-dynamodb"
  attributes                         = var.attributes
  hash_key                           = var.hash_key
  range_key                          = var.range_key
  billing_mode                       = var.billing_mode
  write_capacity                     = var.write_capacity != null ? var.write_capacity : local.config[var.nivel_servicio].write_capacity
  read_capacity                      = var.read_capacity != null ? var.read_capacity : local.config[var.nivel_servicio].read_capacity
  point_in_time_recovery_enabled     = var.point_in_time_recovery_enabled
  ttl_enabled                        = var.ttl_enabled
  ttl_attribute_name                 = var.ttl_attribute_name
  global_secondary_indexes           = var.global_secondary_indexes
  local_secondary_indexes            = var.local_secondary_indexes
  replica_regions                    = var.replica_regions
  stream_enabled                     = var.stream_enabled
  stream_view_type                   = var.stream_view_type
  server_side_encryption_enabled     = var.server_side_encryption_enabled
  server_side_encryption_kms_key_arn = var.server_side_encryption_kms_key_arn
  tags                               = var.labels
  timeouts                           = var.timeouts != null ? var.timeouts : local.config[var.db_type].timeouts
  autoscaling_defaults               = var.autoscaling_defaults
  autoscaling_read                   = var.autoscaling_read
  autoscaling_write                  = var.autoscaling_write
  autoscaling_indexes                = var.autoscaling_indexes
}

module "aurora" {
  count  = var.db_type == "aurora" ? 1 : 0
  source = "terraform-aws-modules/rds-aurora/aws"

  name = var.identifier != null ? "${local.resource_name}-${var.identifier}" : "${local.resource_name}-aurora"
  tags = var.labels

  # aws_db_subnet_group
  create_db_subnet_group = var.create_db_subnet_group
  db_subnet_group_name   = var.db_subnet_group_name != null ? "${local.resource_name}-${var.db_subnet_group_name}" : "${local.resource_name}-subnetgroup"
  subnets                = var.db_subnet_ids

  # aws_rds_cluster
  create_cluster                              = var.create_cluster
  is_primary_cluster                          = var.is_primary_cluster
  global_cluster_identifier                   = var.global_cluster_identifier #!= null ? "${local.resource_name}-${var.global_cluster_identifier}" : "${local.resource_name}-cl-aurora"
  enable_global_write_forwarding              = var.enable_global_write_forwarding
  replication_source_identifier               = var.replication_source_identifier
  source_region                               = var.source_region
  engine                                      = "aurora-postgresql"
  engine_mode                                 = "provisioned"
  engine_version                              = "13.4"
  allow_major_version_upgrade                 = var.allow_major_version_upgrade
  enable_http_endpoint                        = var.enable_http_endpoint
  kms_key_id                                  = var.kms_key_id
  database_name                               = var.database_name
  master_username                             = var.master_username
  create_random_password                      = var.create_random_password
  random_password_length                      = var.random_password_length
  master_password                             = var.password #?
  final_snapshot_identifier_prefix            = var.final_snapshot_identifier_prefix
  skip_final_snapshot                         = var.skip_final_snapshot
  deletion_protection                         = var.deletion_protection
  backup_retention_period                     = var.backup_retention_period
  preferred_backup_window                     = var.backup_window != null ? var.backup_window : local.config[var.nivel_servicio].backup_window
  preferred_maintenance_window                = var.maintenance_window != null ? var.maintenance_window : local.config[var.nivel_servicio].maintenance_window
  port                                        = var.port #?
  vpc_security_group_ids                      = var.vpc_security_group_ids
  snapshot_identifier                         = var.snapshot_identifier
  storage_encrypted                           = var.storage_encrypted
  apply_immediately                           = var.apply_immediately
  db_cluster_parameter_group_name             = var.create_db_parameter_group ? aws_rds_cluster_parameter_group.cluster_parameter_group[0].id : null #var.db_cluster_parameter_group_name != null ? "${var.db_cluster_parameter_group_name}" : "${local.resource_name}-cl-aurora-postgre"
  db_cluster_db_instance_parameter_group_name = var.create_db_parameter_group ? aws_db_parameter_group.instance_parameter_group[0].id : null         #var.db_cluster_db_instance_parameter_group_name != null ? "${local.resource_name}-${var.db_cluster_db_instance_parameter_group_name}" : "${local.resource_name}-db-aurora-postgre"
  iam_database_authentication_enabled         = var.iam_database_authentication_enabled
  backtrack_window                            = var.backtrack_window
  copy_tags_to_snapshot                       = var.copy_tags_to_snapshot
  enabled_cloudwatch_logs_exports             = var.enabled_cloudwatch_logs_exports != null ? var.enabled_cloudwatch_logs_exports : local.config[var.db_type].enabled_cloudwatch_logs_exports
  cluster_timeouts                            = var.cluster_timeouts
  scaling_configuration                       = var.scaling_configuration
  s3_import                                   = var.s3_import
  restore_to_point_in_time                    = var.restore_to_point_in_time != null ? var.restore_to_point_in_time : local.config[var.db_type].restore_to_point_in_time
  cluster_tags                                = var.labels

  # aws_rds_cluster_instances
  instances                             = var.instances
  instances_use_identifier_prefix       = var.instances_use_identifier_prefix
  instance_class                        = local.config[var.nivel_servicio].instance_class
  publicly_accessible                   = var.publicly_accessible
  db_parameter_group_name               = var.create_db_parameter_group ? aws_db_parameter_group.parameter_group[0].id : null # var.parameter_group_name != null ? "${local.resource_name}-${var.parameter_group_name}" : "${local.resource_name}-db-aurora-postgre"
  monitoring_interval                   = local.config[var.nivel_servicio].monitoring_interval                                #?
  auto_minor_version_upgrade            = var.auto_minor_version_upgrade
  performance_insights_enabled          = local.config[var.nivel_servicio].performance_insights_enabled #?
  performance_insights_kms_key_id       = var.performance_insights_kms_key_id
  performance_insights_retention_period = local.config[var.nivel_servicio].performance_insights_retention_period #?
  ca_cert_identifier                    = var.ca_cert_identifier
  instance_timeouts                     = var.instance_timeouts

  # aws_rds_cluster_endpoint
  endpoints = {}

  # aws_rds_cluster_role_association
  iam_roles = {}

  # Enhanced monitoring role
  create_monitoring_role         = var.create_monitoring_role
  monitoring_role_arn            = var.monitoring_role_arn
  iam_role_name                  = var.iam_role_name != null ? var.iam_role_name : "aurora-monitoring-role-${var.project}-${var.environment}"
  iam_role_use_name_prefix       = var.iam_role_use_name_prefix
  iam_role_description           = " IAM Monitoring Aurora Role ${var.environment}"
  iam_role_path                  = var.iam_role_path
  iam_role_managed_policy_arns   = var.iam_role_managed_policy_arns
  iam_role_permissions_boundary  = var.iam_role_permissions_boundary #?
  iam_role_force_detach_policies = var.iam_role_force_detach_policies
  iam_role_max_session_duration  = var.iam_role_max_session_duration

  # aws_appautoscaling_*
  autoscaling_enabled            = var.autoscaling_enabled
  autoscaling_max_capacity       = var.autoscaling_max_capacity
  autoscaling_min_capacity       = var.autoscaling_min_capacity
  predefined_metric_type         = var.predefined_metric_type
  autoscaling_scale_in_cooldown  = var.autoscaling_scale_in_cooldown
  autoscaling_scale_out_cooldown = var.autoscaling_scale_out_cooldown
  autoscaling_target_cpu         = var.autoscaling_target_cpu
  autoscaling_target_connections = var.autoscaling_target_connections

  # aws_security_group
  create_security_group       = var.create_security_group
  vpc_id                      = var.vpc_id
  security_group_description  = "Terraform managed."
  security_group_tags         = var.labels
  allowed_security_groups     = var.allowed_security_groups
  allowed_cidr_blocks         = var.allowed_cidr_blocks
  security_group_egress_rules = var.security_group_egress_rules
}

resource "aws_db_parameter_group" "parameter_group" {
  count = var.db_type == "aurora" && var.create_db_parameter_group ? 1 : 0
  name  = var.parameter_group_name != null ? "${local.resource_name}-${var.parameter_group_name}" : "${local.resource_name}-db-aurora-postgre"
  #name_prefix = var.prefix
  family = "aurora-postgresql13"
  dynamic "parameter" {
    for_each = var.parameters != null ? var.parameters : local.config[var.db_type].parameters
    content {
      apply_method = can(parameter.value["apply_method"]) ? parameter.value["apply_method"] : "immediate"
      name         = parameter.value["name"]
      value        = parameter.value["value"]

    }
  }
  description = var.parameter_group_name != null ? "${local.resource_name}-${var.parameter_group_name}" : "${local.resource_name}-db-aurora-postgre"
  tags        = var.labels
}
resource "aws_db_parameter_group" "instance_parameter_group" {
  count = var.db_type == "aurora" && var.create_db_parameter_group ? 1 : 0
  name  = var.db_cluster_db_instance_parameter_group_name != null ? "${local.resource_name}-${var.db_cluster_db_instance_parameter_group_name}" : "${local.resource_name}-instance-aurora-postgre"
  #name_prefix = var.prefix
  family = "aurora-postgresql13"
  dynamic "parameter" {
    for_each = var.instance_parameters
    content {
      apply_method = can(parameter.value["apply_method"]) ? parameter.value["apply_method"] : "immediate"
      name         = parameter.value["name"]
      value        = parameter.value["value"]
    }
  }
  description = var.db_cluster_db_instance_parameter_group_name != null ? "${local.resource_name}-${var.db_cluster_db_instance_parameter_group_name}" : "${local.resource_name}-instance-aurora-postgre"
  tags        = var.labels
}

resource "aws_rds_cluster_parameter_group" "cluster_parameter_group" {
  count  = var.db_type == "aurora" && var.create_db_parameter_group ? 1 : 0
  name   = var.db_cluster_parameter_group_name != null ? "${var.db_cluster_parameter_group_name}" : "${local.resource_name}-cl-aurora-postgre"
  family = "aurora-postgresql13"
  dynamic "parameter" {
    for_each = var.cluster_parameters
    content {
      apply_method = can(parameter.value["apply_method"]) ? parameter.value["apply_method"] : "immediate"
      name         = parameter.value["name"]
      value        = parameter.value["value"]

    }
  }
  description = var.db_cluster_parameter_group_name != null ? "${var.db_cluster_parameter_group_name}" : "${local.resource_name}-cl-aurora-postgre"
  tags        = var.labels
}

module "eks" {
  count                                 = var.create_eks ? 1 : 0
  source                                = "terraform-aws-modules/eks/aws"
  cluster_name                          = var.eks_name != null ? "${local.resource_name}-${var.eks_name}" : "${local.resource_name}-eks"
  cluster_version                       = var.cluster_version
  vpc_id                                = var.vpc_id
  subnets                               = var.eks_subnets
  cluster_endpoint_private_access       = var.cluster_endpoint_private_access
  cluster_endpoint_public_access        = var.cluster_endpoint_public_access
  cluster_endpoint_private_access_sg    = var.cluster_endpoint_private_access_sg
  cluster_endpoint_private_access_cidrs = var.cluster_endpoint_private_access_cidrs
  cluster_service_ipv4_cidr             = var.cluster_service_ipv4_cidr
  cluster_endpoint_public_access_cidrs  = var.cluster_endpoint_public_access_cidrs
  cluster_delete_timeout                = var.cluster_delete_timeout
  cluster_egress_cidrs                  = var.cluster_egress_cidrs
  cluster_enabled_log_types             = var.cluster_enabled_log_types
  cluster_log_retention_in_days         = var.cluster_log_retention_in_days != null ? var.cluster_log_retention_in_days : local.config[var.nivel_servicio].cluster_log_retention_in_days
  cluster_create_timeout                = var.cluster_create_timeout
  cluster_log_kms_key_id                = var.cluster_log_kms_key_id
  cluster_security_group_id             = var.cluster_security_group_id

  permissions_boundary                           = var.permissions_boundary
  attach_worker_cni_policy                       = var.attach_worker_cni_policy
  aws_auth_additional_labels                     = var.aws_auth_additional_labels
  cluster_create_endpoint_private_access_sg_rule = var.cluster_create_endpoint_private_access_sg_rule
  cluster_create_security_group                  = var.cluster_create_security_group
  kubeconfig_aws_authenticator_command           = var.kubeconfig_aws_authenticator_command
  kubeconfig_aws_authenticator_command_args      = var.kubeconfig_aws_authenticator_command_args
  kubeconfig_aws_authenticator_env_variables     = var.kubeconfig_aws_authenticator_env_variables
  kubeconfig_aws_authenticator_additional_args   = var.kubeconfig_aws_authenticator_additional_args
  kubeconfig_name                                = var.kubeconfig_name
  openid_connect_audiences                       = var.openid_connect_audiences
  kubeconfig_output_path                         = var.kubeconfig_output_path
  kubeconfig_file_permission                     = var.kubeconfig_file_permission
  write_kubeconfig                               = var.write_kubeconfig
  iam_path                                       = var.iam_path

  cluster_update_timeout       = var.cluster_update_timeout
  create_eks                   = var.create_eks_resources
  default_platform             = var.default_platform
  manage_cluster_iam_resources = var.manage_cluster_iam_resources
  cluster_iam_role_name        = var.cluster_iam_role_name
  eks_oidc_root_ca_thumbprint  = var.eks_oidc_root_ca_thumbprint
  enable_irsa                  = var.enable_irsa
  manage_aws_auth              = var.manage_aws_auth
  manage_worker_iam_resources  = var.manage_worker_iam_resources
  wait_for_cluster_timeout     = var.wait_for_cluster_timeout

  # Managed Node Groups 
  node_groups_defaults = var.node_groups_defaults
  node_groups          = var.node_groups != null ? var.node_groups : local.config[var.nivel_servicio].node_groups

  # Fargate 
  fargate_profiles                  = var.fargate_profiles
  fargate_subnets                   = var.fargate_subnets
  create_fargate_pod_execution_role = var.create_fargate_pod_execution_role
  fargate_pod_execution_role_name   = var.fargate_pod_execution_role_name

  # AWS Auth (kubernetes_config_map) 
  map_roles    = var.map_roles
  map_users    = var.map_users
  map_accounts = var.map_accounts


  worker_additional_security_group_ids               = var.worker_additional_security_group_ids
  worker_ami_name_filter                             = var.worker_ami_name_filter
  worker_ami_name_filter_windows                     = var.worker_ami_name_filter_windows
  worker_ami_owner_id                                = var.worker_ami_owner_id
  worker_ami_owner_id_windows                        = var.worker_ami_owner_id_windows
  worker_create_cluster_primary_security_group_rules = var.worker_create_cluster_primary_security_group_rules
  worker_create_initial_lifecycle_hooks              = var.worker_create_initial_lifecycle_hooks
  worker_create_security_group                       = var.worker_create_security_group
  worker_security_group_id                           = var.worker_security_group_id
  worker_groups                                      = var.worker_groups
  worker_groups_launch_template                      = var.worker_groups_launch_template
  worker_sg_ingress_from_port                        = var.worker_sg_ingress_from_port
  workers_additional_policies                        = var.workers_additional_policies
  workers_egress_cidrs                               = var.workers_egress_cidrs
  workers_group_defaults                             = var.workers_group_defaults
  workers_role_name                                  = var.workers_role_name


  tags         = var.labels
  cluster_tags = var.labels
}
