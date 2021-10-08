#password_change_permission
resource "aws_iam_user_policy_attachment" "password_perm_attach" {
  user = aws_iam_user.usera.name
  policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}

#policy statement in form of terraform doc
data "aws_iam_policy_document" "custom_policy" {
  statement {
    actions   = [var.iam_policy_data.actions]
    resources = [var.iam_policy_data.resources]
    effect    = var.iam_policy_data.effect
  }

}

data "aws_iam_policy_document" "assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    resources = var.iam_assume_roles
  }
}

resource "aws_iam_policy" "policy" {
  name        = var.iam_policyTwo
  description = "A test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

#IAM policy document data
data "aws_iam_policy_document" "example1" {
  statement {
       actions = [
      "sts:AssumeRole"
    ]
effect = "Allow"
    resources = [aws_iam_role.test_role.arn , aws_iam_role.role.arn]
  }
}
#role creation 
resource "aws_iam_role" "test_role" {

  name = var.iam_role_name
   
  #role policy attached to role 
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        } 
      },
    ]
  }
    )
}