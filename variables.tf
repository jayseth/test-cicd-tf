variable "aws_region" {

    default = "us-west-2"
  
}

####################################################################################
####################################### vpc-mod ####################################

variable "cidr_vpc" {
    type=string
  
}

variable "public_subnet" {
  type=string
}

variable "private_subnet" {
    type=string
  
}

variable "vpc_subnet_az" {
    type=string
  
}



#####################################################################################
####################################### org_mod #####################################


variable "aws_ou_name" {
    type = list(string)
}

variable "org_enabled_policy" {
     type = list(string)
  
}



#####################################################################################
####################################### iam_mod #####################################
variable "aws_user_name" {
    type = string
  
}

variable "aws_group_name" {
    type = string
  
}


variable "aws_policy_data" {

    type =map(any)
  
}



#####################################################################################
####################################### ec2_mod #####################################

variable "ami_id"{
  description = "AMI ID "
  type = string
  
}
variable "instance_Type"{
  description = "Type of instance"
  type = string
}
