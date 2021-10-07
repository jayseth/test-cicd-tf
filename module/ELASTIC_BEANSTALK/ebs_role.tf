
#Basic role data to be attached to EBS application
data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

#Basic role created using "aws_iam_policy_document" data resource
resource "aws_iam_role" "beanstalk_service" {
  name               = "instance_role"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
}