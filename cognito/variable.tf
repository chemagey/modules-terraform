variable "aws_region" {
  type = string
  default = "eu-central-1"
}

variable "user_pool" {
  type = string
  default = "enagas-cognito-split-terraform"
}

variable "tag_name" {
  type = string
  default = "cognito-split"
}

variable "service" {
  type = string
  default = "gdt"
}

variable "environment" {
  type = string
  default = "dev"
}


variable "adfs" {
  type = string
  default = "ADEnagas"
}

variable "saml_metadata_sso_redirect_binding_uri" {
  type = string
  default = "https://sts.enagas.com/FederationMetadata/2007-06/FederationMetadata.xml"
}

variable "mapping" {
  type = string
  default = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
}

variable "callback" {
  type = string
  default = "https://google.com"
}
