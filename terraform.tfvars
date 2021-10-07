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
