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
