username          = "pepe"
password          = "epeppepe"
nivel_servicio    = "plata"
db_type           = "dynamo"
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
