resource "aws_dynamodb_table" "this" {
  hash_key = "TodoId"
  name     = var.service_name

  write_capacity = 5
  read_capacity  = 5

  attribute {
    name = "TodoId"
    type = "S"
  }

  tags = local.common_tags
}

resource "aws_dynamodb_table_item" "this" {
  hash_key   = aws_dynamodb_table.this.hash_key
  table_name = aws_dynamodb_table.this.name
  item       = <<ITEM
{
"TodoId":{"S": "1"},
"Task":{"S": "Aprender Terraform"},
"Done":{"S": "0"}
}
ITEM
}