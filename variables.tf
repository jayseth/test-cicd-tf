#####################################################################################
###################################  ECS  ###########################################

variable "cluster_name" {
  description = "Cluster name."
}

variable "name_prefix" {
  description = "A prefix used for naming resources."
  type        = string
}

variable "subnets_ids" {
  description = "IDs of subnets. Use subnets from various availability zones to make the cluster more reliable."
  type        = list(string)
}

variable "task_container_image" {
  description = "The image used to start a container."
  type        = string
}

variable "trusted_cidr_blocks" {
  description = "Trusted subnets e.g. with ALB and bastion host."
  type        = list(string)
}


#####################################################################################
####################################### ORG #####################################



variable "org_enabled_policy" {
     type = list(string)
  
}

variable "enable_acc_sa" {
    description = "To enable the creation of account for Security Account OU"
    
    type = bool
  
}

variable "enable_acc_log" {
    description = "To enable the creation of account for Log Archive OU"
    
     type = bool
  
}

variable "enable_acc_ssa" {
    description = "To enable the creation of account for Shared Services Account OU"
    
     type = bool
  
}


variable "aws_account_Org_usr"{
    description = "name for the organization account"
    
    type=list(string)  
}

variable "aws_account_Org_usr_email"{
    description = "email for the organization account"
    
    type=list(string)
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


variable "network_acl_egress" {
    description = "values for egress network acl "
    type = map(any)
    
  
}

variable "network_acl_ingress" {
    description = "values for inegress network acl "
    type = map(any)
   
  
}

variable "security_group_ingress" {
    description = "values for inegress security group "
    type = map(any)
   
  
}

variable "security_group_egress" {
    description = "values for egress security group "
    type = map(any)
   
  
}


#####################################################################################
####################################### vpc_peering ################################

variable "mod_aws_region_peer"{

    description = "peering vpc region"
    type=string
}
variable "mod_aws_profile"{

    description = "aws profile for peering connection"
    type = string
}
variable "mod_vpc_main_subnet_cidr"{

    description = "vpc main subnet"
    type = string
}
variable "mod_vpc_peer_subnet_cidr"{

    description = "vpc peer subnet"
    type = string
}
variable "mod_aws_vpc_sub_az"{

    description = "vpc az"
    type = string
}

#####################################################################################
####################################### ALB #####################################

variable "mod_lb_enable_deletion_protection" {
    description = "deletion protection for ALB"
    type = bool
  
}

variable "mod_lb_type" {
    description = "Load Balancer Type"
    type = string

  
}

variable "mod_aws_vpc_cidr" {
    description = "vpc cidr for ALB"
    type = string
  
}

variable "mod_lb_subnet_count" {
    description = "Number of subnets to be associated with the Lb"
    
  
}
variable "mod_public_subnet_cidr" {
     description="List Public subnets"
     type=list(string)
  
}
variable "mod_alb_vpc_sub_az" {
    description="List availability zones for lb"
    type=list(string)
  
}

variable "mod_lb_listener_rule_priority" {
   description="Sets the rule priority for lb listener"

}

