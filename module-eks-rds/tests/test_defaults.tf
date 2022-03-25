module "main" {
  source         = "../"
  nivel_servicio = var.nivel_servicio
  db_type        = var.db_type
  prefix         = var.prefix
  environment    = var.environment
  project        = var.project
  create_eks     = true
  hash_key       = "id"
  range_key      = "title"

  attributes = [
    {
      name = "id"
      type = "N"
    },
    {
      name = "title"
      type = "S"
    }
  ]

  labels                 = var.labels
  vpc_id                 = "vpc-0c705d9e43490b996"
  vpc_security_group_ids = ["sg-08b2e4250068414b5"]
  db_subnet_ids          = ["subnet-0a6aa70f32ece6474", "subnet-0515e307fa30ffc35"]


  cluster_iam_role_name = var.cluster_iam_role_name
  eks_subnets           = ["subnet-0a6aa70f32ece6474", "subnet-0515e307fa30ffc35"]

  map_roles = [
    #los roles que necesiten acceso
  ]
}



terraform {
  required_version = ">= 0.12.2"

}

#
# Providers.
#

provider "aws" {
  region = "eu-west-1"


}
