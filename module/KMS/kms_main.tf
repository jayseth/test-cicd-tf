resource "aws_kms_key" "new_key" {
  description              = var.kms_key_desc
  deletion_window_in_days  = var.kms_key_deletion_window
  key_usage                = var.kms_key_usage
  customer_master_key_spec = var.kms_key_spec
  is_enabled               = var.kms_key_enabled
  enable_key_rotation      = var.kms_key_rotation


}

resource "aws_kms_alias" "kms_key_alias" {
  name          = "alias/${var.kms_key_alias}"
  target_key_id = aws_kms_key.new_key.id
}


resource "aws_iam_role" "a" {
  name = "iam-role-for-grant"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com" 
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_kms_grant" "kms_key_grant" {
  name              = "my-grant"
  key_id            = aws_kms_key.new_key.id
  grantee_principal = aws_iam_role.a.arn
  operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]

  
  
}