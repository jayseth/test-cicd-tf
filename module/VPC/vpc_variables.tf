

variable "aws_vpc_cidr" {
    description = "CIDR block for VPC"
   
    type = string
  
}

variable "public_subnet_cidr" {
    description = "CIDR block for VPC Subnet"
  
    type = string
  
}


variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    type = string
}

variable "aws_vpc_sub_az" {

    description = "VPC subnet availability zone  "
    
    type = string
   
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


