module "ECS" {

    source = "./module/ECS"

    cluster_name = var.cluster_name
    name_prefix = var.name_prefix
    subnets_ids = var.subnets_ids
    task_container_image = var.task_container_image
    trusted_cidr_blocks = var.trusted_cidr_blocks
}

module "org" {

    source = "./module/ORG"
    
    aws_OU_name     = var.aws_ou_name
    aws_enabled_policy  = var.org_enabled_policy

    enable_acc_log=var.enable_acc_sa
    enable_acc_sa=var.enable_acc_log
    enable_acc_ssa= var.enable_acc_ssa

    aws_account_Org_usr=var.aws_account_Org_usr
    aws_account_Org_usr_email=var.aws_account_Org_usr_email
  
}
    
module "vpc" {

    
    source = "./module/VPC"
    
    aws_vpc_cidr             = var.cidr_vpc
    public_subnet_cidr       = var.public_subnet
    private_subnet_cidr      = var.private_subnet
    aws_vpc_sub_az           = var.vpc_subnet_az

    network_acl_egress     = var.network_acl_egress
    network_acl_ingress    = var.network_acl_ingress
    security_group_ingress = var.security_group_ingress
    security_group_egress  = var.security_group_egress
  
}
 
module "vpc_peering"{

    source = "./module/VPC_PEERING"


    aws_region_peer=var.mod_aws_region_peer
    aws_profile=var.mod_aws_profile
    vpc_main_subnet_cidr=var.mod_vpc_main_subnet_cidr
    vpc_peer_subnet_cidr=var.mod_vpc_peer_subnet_cidr
    aws_vpc_sub_az=var.mod_aws_vpc_cidr


}
    
    
module "alb" {

    source = "./module/ALB"

    enable_deletion_protection   = var.mod_lb_enable_deletion_protection
    lb_type                      = var.mod_lb_type
    aws_vpc_cidr                 = var.mod_aws_vpc_cidr
    lb_subnet_count              = var.mod_lb_subnet_count
    public_subnet_cidr           = var.mod_public_subnet_cidr
    aws_vpc_sub_az               = var.mod_alb_vpc_sub_az
    lb_listener_rule_priority    = var.mod_lb_listener_rule_priority

  
} 
    
    
    
module "EC2" {

source = "./module/EC2"
    
    
region = var.region
profile = var.profile
ami = var.ami
instanceType = var.instanceType
index = var.index
enable_instance =var.enable_instance


#---------------------------------------------------------------------------------------------------------------------------------------

#Custom AMIs (Golden Images)
az = var.az
size =  var.size
rootDevName = var.rootDevName
DevName = var.DevName
enable_custom_ami = var.enable_custom_ami
#---------------------------------------------------------------------------------------------------------------------------------------
#ASG
enable_asg = var.enable_asg
des_capacity = var.des_capacity
maxSize = var.maxSize
minSize = var.minSize
namePrefix = var.namePrefix
imgID = var.imgID

#----------------------------------------------------------------------------------------------------------

#Auto Start - Stop
enable_auto_start_stop = var.enable_auto_start_stop
timeout = var.timeout

#----------------------------------------------------------------------------------------------------------

#Automated Session Manager in Private network
enable_auto_sess_manager = var.enable_auto_sess_manager
availability_zones = var.availability_zones
name               = var.name
private_start_ip   = var.private_start_ip
public_start_ip    = var.public_start_ip
subnet_prefix      = var.subnet_prefix
vpc_cidr           = var.vpc_cidr
  
}

  
module "fsxwindows" {

    source = "./module/FSx_WINDOWS"

    
    fsx_win_capacity             = var.mod_fsx_win_capacity
    fsx_win_throughtput_capacity =var.mod_fsx_win_throughtput_capacity
    fsx_vpc_cidr                 = var.mod_fsx_vpc_cidr
    fsx_win_subids               = var.mod_fsx_win_subids
    fsx_win_sub_az               = var.fsx_win_sub_az

    serv_directory_name          = var.mod_serv_directory_name
    serv_directory_password      = var.mod_serv_directory_password
    serv_directory_size          = var.mod_serv_directory_size
    serv_directory_type          = var.mod_serv_directory_type
    
  
}

module "fsxlustre" {

    source = "./module/FSxLUSTRE"

    
   fsx_lustre_capacity          = var.mod_fsx_lustre_capacity
   fsx_lus_vpc_cidr             = var.fsx_lus_vpc_cidr
   fsx_lus_sub_cidr             = var.fsx_lus_sub_cidr
  
}

