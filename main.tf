module "iam_user_1_mod" {

    source = "./module/iam"

    aws_new_user  = var.aws_user_name
    aws_new_group = var.aws_group_name
    policy_data  =  var.aws_policy_data
    
    
  
}


module "vpc_mod" {

    
    source = "./module/vpc"
    
    aws_vpc_cidr             = var.cidr_vpc
    public_subnet_cidr       = var.public_subnet
    private_subnet_cidr      = var.private_subnet
    aws_vpc_sub_az           = var.vpc_subnet_az

  
}


module "org_mod" {

    source = "./module/org"
    aws_OU_name     = var.aws_ou_name
    aws_enabled_policy  = var.org_enabled_policy
  
}


module "ec2" {

    source = "./module/ec2"
    ami = var.ami_id
    instanceType = var.instance_Type
  
  
}