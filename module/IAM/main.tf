#Create an IAM user with a policy using permission_boundary attribute
resource "aws_iam_user" "usera" {
  name                 = var.iam_name
  force_destroy        = var.iam_force_destroy
  permissions_boundary = var.iam_permissions_boundary
}

#Manage the created IAM user with encrypted password generated
resource "aws_iam_user_login_profile" "usera_profile" {
  user                    = aws_iam_user.usera.name
  pgp_key                 = var.iam_pgp_key
  password_length         = var.iam_password_length
  password_reset_required = var.iam_password_reset_required
}

resource "aws_iam_policy" "custom_pol" {
  name   = var.iam_custom_policy_name
  description = var.iam_custom_policy_description
  policy = data.aws_iam_policy_document.custom_policy.json
}

#group
resource "aws_iam_group" "new_group" {
  name = var.iam_aws_new_group   
}

#adding user-1 to group developers

resource "aws_iam_user_group_membership" "new_group" {
  user = aws_iam_user.usera.name

  groups = [
    aws_iam_group.new_group.name,
  ]
}

#Attaching a policy to group
resource "aws_iam_group_policy_attachment" "attach_group" {
  group       = aws_iam_group.new_group.name
  policy_arn = aws_iam_policy.custom_pol.arn
  
}

resource "aws_iam_policy" "policy_instance" {
  name               = "assumeable_role"
  description        = "Allows to assume role in another AWS account"
  policy             = data.aws_iam_policy_document.assume-role-policy.json
}

#Attaching a policy to group
resource "aws_iam_group_policy_attachment" "assumable_role_group" {
  group       = aws_iam_group.new_group.name
  policy_arn = aws_iam_policy.policy_instance.arn
 
}

#iam group created
resource "aws_iam_group" "this" {

  name = var.iam_assumable_role_group_name
}

#iam group policy attachment
resource "aws_iam_group_policy_attachment" "this" {
  group      = aws_iam_group.this.id
  policy_arn = aws_iam_policy.policy_instance.id
}

resource "aws_iam_group_membership" "this" {
  group = aws_iam_group.this.id
  name  = var.iam_name
  users = var.iam_group_users
}

#Attaches a Managed IAM Policy to an IAM role
resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_role" "role" {
  name = "test-role"

#role policy assumed
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
}

#IAM policy 
resource "aws_iam_policy" "example1" {
  name   = "example_policy"
  policy = data.aws_iam_policy_document.example1.json
}


#IAM group created
resource "aws_iam_group" "developers" {
  name = var.iam_role_groupname
}

#Attaching group policy arn
resource "aws_iam_group_policy_attachment" "test-attach" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.example1.arn
}

resource "aws_iam_group_membership" "iam_arn_roles" {
  group = aws_iam_group.developers.id
  name  = var.iam_iamarnname
  users = var.iam_group_users
}