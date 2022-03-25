output "cloudwatch_log_group_arn" {
  value = try(module.eks[0].cloudwatch_log_group_arn, null)
}
output "cloudwatch_log_group_name" {
  value = try(module.eks[0].cloudwatch_log_group_name, null)
}
output "cluster_arn" {
  value = try(module.eks[0].cluster_arn, null)
}
output "cluster_certificate_authority_data" {
  value = try(module.eks[0].cluster_certificate_authority_data, null)
}
output "cluster_endpoint" {
  value = try(module.eks[0].cluster_endpoint, null)
}
output "cluster_iam_role_arn" {
  value = try(module.eks[0].cluster_iam_role_arn, null)
}
output "cluster_id" {
  value = try(module.eks[0].cluster_id, null)
}
output "cluster_oidc_issuer_url" {
  value = try(module.eks[0].cluster_oidc_issuer_url, null)
}
output "cluster_primary_security_group_id" {
  value = try(module.eks[0].cluster_primary_security_group_id, null)
}
output "cluster_security_group_id" {
  value = try(module.eks[0].cluster_security_group_id, null)
}
output "cluster_version" {
  value = try(module.eks[0].cluster_version, null)
}
output "config_map_aws_auth" {
  value = try(module.eks[0].config_map_aws_auth, null)
}
output "fargate_iam_role_arn" {
  value = try(module.eks[0].fargate_iam_role_arn, null)
}
output "fargate_iam_role_name" {
  value = try(module.eks[0].fargate_iam_role_name, null)
}
output "fargate_profile_arns" {
  value = try(module.eks[0].fargate_profile_arns, null)
}
output "fargate_profile_ids" {
  value = try(module.eks[0].fargate_profile_ids, null)
}
output "kubeconfig" {
  value = try(module.eks[0].kubeconfig, null)
}
output "kubeconfig_filename" {
  value = try(module.eks[0].kubeconfig_filename, null)
}
output "node_groups" {
  value = try(module.eks[0].node_groups, null)
}
output "oidc_provider_arn" {
  value = try(module.eks[0].oidc_provider_arn, null)
}
output "security_group_rule_cluster_https_worker_ingress" {
  value = try(module.eks[0].security_group_rule_cluster_https_worker_ingress, null)
}

output "db_instance_address" {
  value = try(module.rds[0].db_instance_address, null)
}
output "db_instance_arn" {
  value = try(module.rds[0].db_instance_arn, null)
}

output "db_instance_availability_zone" {
  value = try(module.rds[0].db_instance_availability_zone, null)
}

output "db_instance_ca_cert_identifier" {
  value = try(module.rds[0].db_instance_ca_cert_identifier, null)
}

output "db_instance_domain" {
  value = try(module.rds[0].db_instance_domain, null)
}

output "db_instance_domain_iam_role_name" {
  value = try(module.rds[0].db_instance_domain_iam_role_name, null)
}

output "db_instance_endpoint" {
  value = try(module.rds[0].db_instance_endpoint, null)
}

output "db_instance_hosted_zone_id" {
  value = try(module.rds[0].db_instance_hosted_zone_id, null)
}

output "db_instance_id" {
  value = try(module.rds[0].db_instance_id, null)
}

output "db_instance_name" {
  value = try(module.rds[0].db_instance_name, null)
}

output "db_instance_password" {
  value = try(module.rds[0].db_instance_password, null)
}

output "db_instance_port" {
  value = try(module.rds[0].db_instance_port, null)
}

output "db_instance_resource_id" {
  value = try(module.rds[0].db_instance_resource_id, null)
}

output "db_instance_status" {
  value = try(module.rds[0].db_instance_status, null)
}
output "db_instance_username" {
  value = try(module.rds[0].db_instance_username, null)
}
output "db_master_password" {
  value = try(module.rds[0].db_master_password, null)
}
output "db_option_group_arn" {
  value = try(module.rds[0].db_option_group_arn, null)
}
output "db_option_group_id" {
  value = try(module.rds[0].db_option_group_id, null)
}
output "db_parameter_group_arn" {
  value = try(module.rds[0].db_parameter_group_arn, null)
}
output "db_parameter_group_id" {
  value = try(module.rds[0].db_parameter_group_id, null)
}
output "db_subnet_group_arn" {
  value = try(module.rds[0].db_subnet_group_arn, null)
}
output "db_subnet_group_id" {
  value = try(module.rds[0].db_subnet_group_id, null)
}
output "enhanced_monitoring_iam_role_arn" {
  value = try(module.rds[0].enhanced_monitoring_iam_role_arn, null)
}
output "enhanced_monitoring_iam_role_name" {
  value = try(module.rds[0].enhanced_monitoring_iam_role_name, null)
}

output "database" {
  value = try(module.rds, module.dynamodb, module.aurora, null)
}

output "eks" {
  value = try(module.eks, null)
}






