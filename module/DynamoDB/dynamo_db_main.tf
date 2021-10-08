resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = var.db_name
  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key#attribute has to be difined for this
  range_key      = var.range_key#attribute has to be difined for this
  stream_enabled = var.stream_enabled_dynamodb
  stream_view_type = var.stream_view_type_dynamodb


  attribute {
    name = var.hash_key
    type = "S"
  }

  attribute {
    name = var.range_key
    type = "S"
  }

 
  ttl {
    attribute_name = var.ttl_attribute_name
    enabled        = var.ttl_enable
  }



  
}