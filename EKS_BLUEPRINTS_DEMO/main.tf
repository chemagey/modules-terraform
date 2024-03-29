provider "kubernetes" {
  host                   = module.eks_blueprints.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_blueprints.eks_cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes {
    host                   = module.eks_blueprints.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks_blueprints.eks_cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token

  }
}

provider "kubectl" {
  apply_retry_count      = 10
  host                   = module.eks_blueprints.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_blueprints.eks_cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}


module "eks_blueprints" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.0.7"

  cluster_name    = local.name

  # EKS Cluster VPC and Subnet mandatory config
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets

  # EKS CONTROL PLANE VARIABLES
  cluster_version = local.cluster_version


  # EKS MANAGED NODE GROUPS
  managed_node_groups = {
    mg_5 = {
      node_group_name = "managed-ondemand"
      instance_types  = ["t3.medium"]
      subnet_ids      = module.vpc.private_subnets
    }
  }
  platform_teams = {
    admin = {
      users = [
        data.aws_caller_identity.current.arn
      ]
    }
  }

tags = local.tags
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  #version = "v3.2.0"
  version = "~> 3.0"

  name = local.name
  cidr = local.vpc_cidr

  azs  = local.azs
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 10)]

  enable_nat_gateway   = true
  create_igw           = true
  enable_dns_hostnames = true
  single_nat_gateway   = true

  # Manage so we can name
  manage_default_network_acl    = true
  default_network_acl_tags      = { Name = "${local.name}-default" }
  manage_default_route_table    = true
  default_route_table_tags      = { Name = "${local.name}-default" }
  manage_default_security_group = true
  default_security_group_tags   = { Name = "${local.name}-default" }  

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.name}" = "shared"
    "kubernetes.io/role/elb"              = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.name}" = "shared"
    "kubernetes.io/role/internal-elb"     = "1"
  }

    tags = local.tags
}

module "aws_controllers" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.0.7/modules/kubernetes-addons"

  eks_cluster_id = module.eks_blueprints.eks_cluster_id

  #---------------------------------------------------------------
  # Use AWS controllers separately
  # So that it can delete ressources it created from other addons or workloads
  #---------------------------------------------------------------

  enable_aws_load_balancer_controller = true
  enable_karpenter                    = false
  enable_aws_for_fluentbit            = false

  depends_on = [module.eks_blueprints.managed_node_groups]
}


# Add the following to the bottom of main.tf

module "kubernetes-addons" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.0.7/modules/kubernetes-addons"

  eks_cluster_id = module.eks_blueprints.eks_cluster_id


  enable_argocd         = true
  argocd_manage_add_ons = true # Indicates that ArgoCD is responsible for managing/deploying Add-ons.
  argocd_applications = {
    addons    = local.addon_application
    workloads = local.workload_application
  }

  argocd_helm_config = {
    values = [templatefile("${path.module}/argocd-values.yaml", {})]
  }


  enable_aws_for_fluentbit            = false
  enable_cert_manager                 = false
  enable_cluster_autoscaler           = false
  enable_ingress_nginx                = false
  enable_keda                         = false
  enable_metrics_server               = false
  enable_prometheus                   = false
  enable_traefik                      = false
  enable_vpa                          = false
  enable_yunikorn                     = false
  enable_argo_rollouts                = false

  depends_on = [module.eks_blueprints.managed_node_groups,module.aws_controllers]
}
