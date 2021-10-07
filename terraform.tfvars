######################################################################################
###################################  ECS  ############################################

cluster_name = "test"
name_prefix = "test"
subnets_ids = ["subnet-6f6a5361"]
task_container_image = "test"
trusted_cidr_blocks = ["172.31.64.0/20"]

#####################################################################################
####################################### org_mod #####################################

aws_ou_name=["Security Account","Log Archive","Shared Services Account"]
org_enabled_policy=["SERVICE_CONTROL_POLICY"]

 enable_acc_log=false
 enable_acc_sa=false
 enable_acc_ssa= false
 aws_account_Org_usr=["user-3","user-4"]
 aws_account_Org_usr_email= ["av9152@srmist.edu.in","arul_saxena@srmuniv.edu.in"]

####################################################################################
####################################### vpc-mod ####################################

cidr_vpc="10.0.0.0/16"
public_subnet="10.0.0.0/24"
private_subnet="10.0.1.0/24"
vpc_subnet_az="us-west-2a"

network_acl_egress     = {
            protocol   = "tcp"
            rule_no    = 200
            action     = "allow"
            from_port  = 443
            to_port    = 443
}
network_acl_ingress    ={
            protocol   = "tcp"
            rule_no    = 100
            action     = "allow"
            from_port  = 80
            to_port    = 80
}
security_group_ingress ={
            description = "TLS from VPC"
            from_port   = 443
            to_port     = 443
            protocol    = "tcp"
          
}
security_group_egress  ={
          from_port    = 0
          to_port      = 0
          protocol     = "-1"
       
}

#####################################################################################
####################################### vpc_peering #################################

mod_aws_region_peer="us-east-1"
mod_aws_profile="terraform-practice"
mod_vpc_main_subnet_cidr="10.0.0.0/16"
mod_vpc_peer_subnet_cidr="10.1.0.0/16"
mod_aws_vpc_sub_az="us-west-2a"

#####################################################################################
####################################### ALB #########################################


mod_lb_enable_deletion_protection   = false
mod_lb_type                      = "application"
mod_aws_vpc_cidr                 = "10.0.0.0/16"
mod_lb_subnet_count              = 2
mod_public_subnet_cidr           = ["10.0.0.0/24","10.0.1.0/24"]
mod_alb_vpc_sub_az               = ["us-west-2a","us-west-2b"]
mod_lb_listener_rule_priority    = 100


#####################################################################################
####################################### ec2_mod #####################################

#----------------------------------------------------------------------------------------
#ec2 instance

enable_instance = false #Set true to deploy instance
ami = {east1 = "ami-087c17d1fe0178315", east2 = "ami-00dfe2c7ce89a450b", west-1="ami-011996ff98de391d1",west-2="ami-0c2d06d50ce30b442"}
instanceType = "t2.micro"
index =0


#---------------------------------------------------------------------------------------------------------------------------------------

#Custom AMIs (Golden Images)
enable_custom_ami = false
az = {east1a = "us-east-1a" , east1b = "us-east-1b"}
size =  40
rootDevName = "/dev/xvda"
DevName = "/dev/xvda"

#---------------------------------------------------------------------------------------------------------------------------------------
#ASG
enable_asg = false
des_capacity = 1
maxSize = 1
minSize = 1
namePrefix = "foobar"
imgID = "ami-087c17d1fe0178315"

#----------------------------------------------------------------------------------------------------------

#Auto Start - Stop
enable_auto_start_stop = true
timeout = "300"

#----------------------------------------------------------------------------------------------------------

#Automated Session Manager in Private network
enable_auto_sess_manager = false
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
name               = "NAME OF YOUR APPLICATION"
private_start_ip   = "30"
public_start_ip    = "20"
subnet_prefix      = "10.0"
vpc_cidr           = "10.0.0.0/16"
