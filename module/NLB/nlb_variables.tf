

variable "aws_network_lb_name" {
    description = "Name of the network Loadbalancer"
    default = "network-lb-tf"
    type = string
  
}

variable "lb_type" {
    description = "load balancer type"
    default     = "network"
    type        =  string 
  
}

variable "enable_deletion_protection" {
    description = "Deletion protection for Load Balancer"
    default = true
  
}

variable "aws_vpc_cidr" {
    description = "CIDR block for VPC"
    default = "10.0.0.0/16"
    type = string
  
}

variable "public_subnet_cidr" {
    description = "CIDR block for VPC Subnet"
    default = ["10.0.0.0/24","10.0.1.0/24"]
    type = list(string)
  
}



variable "aws_vpc_sub_az"{
description = "Availibilty zone of subnet"
default = ["us-west-2a","us-west-2b"]
type=list(string)
}

variable "private_ip_EIPS" {
    description ="Eips private ips"
    default     =["10.0.0.12","10.0.0.11"]
    type = list(string)
}





variable "lb_subnet_count" {
    description = "no. of subnets for load balancer(minimum 2 required)"
    default = 2
  
}

variable "lb_listener_rule_priority" {
    description = "LB rule priority"
    default = 100
  
}