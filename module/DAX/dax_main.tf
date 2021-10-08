resource "aws_dax_cluster" "new_cluster" {
  cluster_name       =  var.dax_cluster_name
  iam_role_arn       = aws_iam_role.dynamodb.arn
  node_type          =  var.dax_node_type
  replication_factor =  var.dax_replication_factor
  availability_zones = var.dax_az
}


resource "aws_iam_role" "dynamodb" {
  name = "dynamodb_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "dax.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

#Policy document to extend role

data "aws_iam_policy_document" "dynamodb_doc" {
    statement{
        sid = ""
        actions = ["iam:CreateServiceLinkedRole","dax:GetItem","dax:PutItem","dax:ConditionCheckItem","dax:BatchGetItem"]
        resources = ["*"]
        effect = "Allow"
    }
    
}

#creating the policy from policy document resource
resource "aws_iam_policy" "dynamodb_policy" {
    name = "dynamodb_policy"
    path = "/"
    description = "DAX Policy"
    policy = data.aws_iam_policy_document.dynamodb_doc.json
}

#Attaching the policy to Role to extend the fuctioning of the Role
resource "aws_iam_role_policy_attachment" "dynamodb_attachment" {
    policy_arn = aws_iam_policy.dynamodb_policy.arn
    role = aws_iam_role.dynamodb.id
}
