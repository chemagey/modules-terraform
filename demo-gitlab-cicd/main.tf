module "aws_dynamodb_table" {
  source   = "git::https://innersource.soprasteria.com/aceleracion-digital/es_aws_terraform/modules/es-terraform-aws-dynamodb.git?ref=master"

  name     = "table-dummy${terraform.workspace}"
  hash_key = "LockID${terraform.workspace}"
  billing_mode = "PAY_PER_REQUEST"
  attributes = [
    {
      name = "LockID${terraform.workspace}"
      type = "N"
    }
  ]
}
