# AWS DynamoDB Table Terraform module

Terraform module to create a DynamoDB table.

## Usage

```hcl
module "aws_dynamodb_table" {
  source   = "git::https://innersource.soprasteria.com/aceleracion-digital/es_aws_terraform/modules/es-terraform-aws-dynamodb.git?ref=master"

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
```

## Examples

- [Basic example](https://innersource.soprasteria.com/aceleracion-digital/es_aws_terraform/modules/dynamodb/tree/master/examples/basic)
- [Autoscaling example](https://innersource.soprasteria.com/aceleracion-digital/es_aws_terraform/modules/dynamodb/tree/master/examples/autoscaling)
- [Global tables example](https://innersource.soprasteria.com/aceleracion-digital/es_aws_terraform/modules/dynamodb/tree/master/examples/global-tables)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.70.0 |


## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamodb_table_arn"></a> [dynamodb\_table\_arn](#output\_dynamodb\_table\_arn) | ARN of the DynamoDB table |
| <a name="output_dynamodb_table_id"></a> [dynamodb\_table\_id](#output\_dynamodb\_table\_id) | ID of the DynamoDB table |
| <a name="output_dynamodb_table_stream_arn"></a> [dynamodb\_table\_stream\_arn](#output\_dynamodb\_table\_stream\_arn) | The ARN of the Table Stream. Only available when var.stream\_enabled is true |
| <a name="output_dynamodb_table_stream_label"></a> [dynamodb\_table\_stream\_label](#output\_dynamodb\_table\_stream\_label) | A timestamp, in ISO 8601 format of the Table Stream. Only available when var.stream\_enabled is true |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

