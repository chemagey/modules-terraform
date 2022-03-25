module "terraform-aws-dynamodb" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  name     = "table-dummy"
  hash_key = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attributes = [
    {
      name = "LockID"
      type = "N"
    }
  ]
}

