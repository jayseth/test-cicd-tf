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
###################################  EKS  ###########################################

variable "eks_availability_zones" {
  type        = list(string)
  description = "List of availability zones"
}

variable "desired_size" {
  type        = number
  description = "Desired number of worker nodes"
}

variable "max_size" {
  type        = number
  description = "The maximum size of the AutoScaling Group"
}

variable "min_size" {
  type        = number
  description = "The minimum size of the AutoScaling Group"
}
  



#####################################################################################
####################################### ORG #####################################


variable "aws_ou_name" {
    description = "List of Organization Unit Names for landing zone"
    type = list(string)
}

variable "org_enabled_policy" {
     description = "List of enabled policy types for the organization "
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

#####################################################################################
####################################### ec2_mod #####################################

#variables for instance creation
variable "region"{
    description = " Name of region "
    type = string
       
}
variable "profile"{
  description = "Name of profile"
  type = string
  
}
variable "enable_instance" {
  type = bool
  description = " Want to deploy EC2 instance ? (true / false)"
}
variable "ami"{
  description = "AMI ID "
  type = map(any)
    
}
variable "instanceType"{
  description = "Type of instance"
  type = string
  default= "t2.micro"
}

variable "index" {
    description = "Index number"
    type = number
    default=0
}

#-------------------------------------------------------------------------------------------------------



#Golden Image   (need to put list of AZs)

variable "az" {
    description = "Name of AZ"
  type = map(any)
  
}
variable "enable_custom_ami" {
  type = bool
  description = " Want to deploy custom AMI ? (true / false)"
}
variable "size" {
    description = "Size"
  type = number
  default=  40
}
variable "rootDevName" {
    description = "Root Device Name"
  type = string
  default=  "/dev/xvda"
}
variable "DevName" {
  description = "Device name of block"
  type = string
  default = "/dev/xvda"
}

#------------------------------------------------------------------------------------------------------------


#ASG Variables
variable "enable_asg" {
  description = "Want to deploy Auto Scaling Groups ? (true/false)"
  type = bool
}
variable "des_capacity" {
  description = "Desired capacity of ASG"
  type = number
  default = 1
}
variable "maxSize" {
  description = "Maximum size of ASG"
  type = number
  
}
variable "minSize" {
  description = "Minimum size of ASG"
  type = number
  
}

variable "namePrefix" {
  description = "Name Prefix of AWS launch Template"
  type = string
  
}

variable "imgID" {
  description = "Image ID of launch template"
  type = string
  
}


#----------------------------------------------------------------------------------------



#Auto Start - Stop


variable "timeout" {
  type = string
  description = " Duration for timeout"
  
}
variable "enable_auto_start_stop" {
  type = bool 
  description = "Want to enable auto start - stop functionality for EC2 instance ? (true /false)"
}


#------------------------------------Auto Sessions Manager--------------------------------------

variable "enable_auto_sess_manager" {
  description = "Want to enable Automatic Sessions Manager ? (true/false)"
  type = bool
}
variable "availability_zones" {
  description = "AWS AVailability Zones"
  type        = list
}

variable "name" {
  description = "Application Name"
  type        = string
}

variable "public_start_ip" {
  description = "Start ip of public subnets"
  type        = string
}

variable "private_start_ip" {
  description = "Start ip of private subnets"
  type        = string
}

variable "subnet_prefix" {
  description = "Prefix for setup of subnets"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR of the VPC"
  type        = string
}

locals {
  az_count = length(var.availability_zones)
}

#####################################################################################
####################################### fsx Windows #################################




variable "mod_fsx_win_capacity" {
    description = "fsx windows file system capacity"
    default = 300
  
}

variable "mod_fsx_win_throughtput_capacity" {

    description = "fsx windows file system throughtput capacity"
    default = 1024
  
}

variable "mod_fsx_vpc_cidr" {
    description = "vpc id for fsx windows directory"
    type=string
  
}

variable "mod_fsx_win_subids" {

    description = "list of subnet ids for the fsx windows file system"
    type=list(string)
  
}

variable "fsx_win_sub_az" {
    description = "sets the AZ for subnets"
    type = list(string)
  
}

variable "mod_serv_directory_name" {
    description ="service directory name"
    type = string
  
}

variable "mod_serv_directory_password" {
    description = "service directory password"
     type = string
  
}

variable "mod_serv_directory_size" {
  
  description = "service directory size"
   type = string
}

variable "mod_serv_directory_type" {
    description = "service directory type"
    type = string
  
}


#####################################################################################
####################################### fsx Lustre ##################################



variable "mod_fsx_lustre_capacity" {
    description = "fsx lustre file system capacity"
    default = 1200
  
}



variable "fsx_lus_vpc_cidr" {

        description = "fsx lustre vpc cidr"
        type = string
      
}

variable "fsx_lus_sub_cidr" {

        description = "fsx lustre subnet cidr"
        type = string
      
}

#----------------------------------------------ncd----------------------------------------------------------------
variable "vpc_cidr_ncd" {
description = "VPC CIDR "
type = string
default = "10.0.0.0/18"
}
variable "pub_cidr" {
    description = "Public network CIDR"
    type = string
    default = "10.0.0.0/24"
}
variable "cidr_rt" {
    description = "Routing table CIDR"
    type = string
    default = "0.0.0.0/0"
}

#-------------------------------------------------------------------------------------------------------------------------------------------


#NAT GATEWAY VARIABLES

variable "priv_cidr" {
    type = string 
    default = "10.0.1.0/24"
}


#-------------------------------------------------------------------------------------------------------------------------------------------

#ROUTE53 HEALTH CHECK VARIABLES

variable "hc_name" {
  description = "The name of the check"
  
}

variable "fqdn" {
  description = "The fully qualified domain name of the endpoint to be checked"
  type = bool
}

variable "port" {
  description = "The port of the endpoint to be checked"
  type = number
}

variable "protocol_type" {
  description = "The protocol to use when performing health checks. Valid values are HTTP, HTTPS, HTTP_STR_MATCH, HTTPS_STR_MATCH, TCP, CALCULATED and CLOUDWATCH_METRIC"
  type = string
}

variable "resource_path" {
  description = "The path that you want Amazon Route 53 to request when performing health checks."
}

variable "failure_threshold" {
  description = "The number of consecutive health checks that an endpoint must pass or fail."
  type = string
}

variable "request_interval" {
  description = "The number of seconds between the time that Amazon Route 53 gets a response from your endpoint and the time that it sends the next health-check request."
  type = string
}

variable "sns_topic" {
  description = "SNS topic where publish alert"
}
variable "namespace" {
    type = string
    description = "Cloudwatch namespace"
}
variable "metric_name" {
    type = string 
    description = "Cloudwatch Metric Name"
}

variable "comparison_operator" {
    type = string
}

variable "evaluation_periods" {
    type = string 
}
variable "period" {
    type = string 
}
variable "statistic" {
    type = string
}
variable "threshold" {
    type = string
}
variable "unit" {
    type = string 
}

variable "treat_missing_data" {
    type = string
}

#-------------------------------------------------------------------------------------------------------------------------------------


#ROUTE53 RECORDS

variable "record_enabled" {
  type        = bool
  description = "Whether to create Route53 record set."
}

variable "record_type" {
  type        = string
  description = "The record type. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT. "
}

variable "ttl" {
  type        = number
  description = "(Required for non-alias records) The TTL of the record."
}

variable "r53_rec_name" {
  type        = string
  description = "The name of the record."
}

variable "values" {
  type        = string
  description = "(Required for non-alias records) A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM, add \"\" inside the Terraform configuration string (e.g. \"first255characters\"\"morecharacters\")."
}

variable "set_identifier" {
  type        = string
  description = "Unique identifier to differentiate records with routing policies from one another. Required if using failover, geolocation, latency, or weighted routing policies documented below."
}

variable "alias" {
  type        = map(any)
  description = "An alias block. Conflicts with ttl & records. Alias record documented below."
}

variable "multivalue_answer_routing_policy" {
  
  description = "Set to true to indicate a multivalue answer routing policy. Conflicts with any other routing policy."
}

variable "allow_overwrite" {
  type        = bool
  description = "Allow creation of this record in Terraform to overwrite an existing record, if any. This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform or manual Route 53 changes outside Terraform from overwriting this record. false by default. This configuration is not recommended for most environments."
}

variable "zone_name" {
  type = string 
  description = "Name of zone"
}

#----------------------------------------------------------------------------------------------------------------------------------


#####################################################################################
####################################### Elastic Beanstalk ###########################


variable "mod_ebs_name" {
    description = "name for the ebs application"
    
    type=string
  
}

variable "mod_ebs_application_version_name" {
    description = "name for the ebs application version"
    
    type= string
}

variable "mod_app_version_source" {
    description = "Source for application version file"
    
    type = string
}


#####################################################################################
####################################### NLB #####################################


variable "mod_nlb_enable_deletion_protection" {
    description = "deletion protection for ALB"
    type = bool
  
}

variable "aws_network_lb_name" {
    description = "sets the name for nlb"
    type = string
  
}

variable "mod_nlb_type" {
    description = "Load Balancer Type"
    type = string

  
}

variable "mod_nlb_vpc_cidr" {
    description = "vpc cidr for ALB"
    type = string
  
}

variable "mod_nlb_subnet_count" {
    description = "Number of subnets to be associated with the Lb"
    
  
}
variable "mod_nlb_public_subnet_cidr" {
     description="List Public subnets"
     type=list(string)
  
}
variable "mod_nlb_vpc_sub_az" {
    description="List availability zones for lb"
    type=list(string)
  
}

variable "private_ip_EIPS" {
    description = "list for private eips"
    type = list(string)
  
}

variable "mod_nlb_listener_rule_priority" {
   description="Sets the rule priority for lb listener"

}

