output "Username" {
  description = "IAM user-name"
  value = aws_iam_user.usera.name
}

output "Encrypted_password" {
  description = "The encrypted password, base64 encoded"
  value = aws_iam_user_login_profile.usera_profile.encrypted_password
}