
####################################################################################
####################################### vpc-mod ####################################

cidr_vpc="10.0.0.0/16"
public_subnet="10.0.0.0/24"
private_subnet="10.0.1.0/24"
vpc_subnet_az="us-west-2a"


#####################################################################################
####################################### org_mod #####################################

aws_ou_name=["Security Account","Log Archive","Shared Services Account"]
org_enabled_policy=["SERVICE_CONTROL_POLICY"]




#####################################################################################
####################################### iam_mod #####################################

aws_user_name  = "user-1"
aws_group_name = "Developers"
aws_policy_data  = {
            actions   = "s3:ListAllMyBuckets"
            resources = "arn:aws:s3:::*"
             effect    = "Allow"
}



#####################################################################################
####################################### ec2_mod #####################################

ami_id = "ami-0c2d06d50ce30b442"
instance_Type = "t2.micro"