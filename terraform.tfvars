######################################################################################
###################################  ECS  ############################################

cluster_name = "test"
name_prefix = "test"
subnets_ids = ["subnet-6f6a5361"]
task_container_image = "test"
trusted_cidr_blocks = ["172.31.64.0/20"]


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

