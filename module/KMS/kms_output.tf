output "kms_key_id" {

    value = aws_kms_key.new_key.id
  
}

output "kms_key_alias" {

    value = aws_kms_alias.kms_key_alias.id
  
}