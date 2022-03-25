variable "username" {
  type = string
}
variable "password" {
  type = string
}
variable "nivel_servicio" {
  type        = string
  description = ""
}

variable "db_type" {
  type        = string
  description = ""
}


variable "create_eks" {
  type        = bool
  description = ""
  default     = true
}

variable "prefix" {
  type        = string
  description = ""
}

variable "environment" {
  type        = string
  description = ""
}

variable "project" {
  type        = string
  description = ""
}


variable "database_name" {
  type        = string
  description = ""
}

variable "allocated_storage" {
  type        = number
  description = ""
}

variable "instance_class" {
  type        = string
  description = ""

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
}

#############################################################
###                     VARIABLES EKS                     ###
#############################################################

variable "cluster_iam_role_name" {
  type        = string
  description = ""
  default     = null
}