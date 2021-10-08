######################################################################################
###################################  ECS  ############################################

cluster_name = "test"
name_prefix = "test"
subnets_ids = ["subnet-6f6a5361"]
task_container_image = "test"
trusted_cidr_blocks = ["172.31.64.0/20"]


######################################################################################
###################################  EKS  ############################################

eks_availability_zones = ["us-east-1a","us-east-1d"]  
desired_size = 2
max_size = 2
min_size = 1

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
vpc_subnet_az="us-east-1a"

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
mod_aws_vpc_sub_az="us-east-1a"

#####################################################################################
####################################### ALB #########################################


mod_lb_enable_deletion_protection   = false
mod_lb_type                      = "application"
mod_aws_vpc_cidr                 = "10.0.0.0/16"
mod_lb_subnet_count              = 2
mod_public_subnet_cidr           = ["10.0.0.0/24","10.0.1.0/24"]
mod_alb_vpc_sub_az               = ["us-east-1a","us-east-1b"]
mod_lb_listener_rule_priority    = 100
alb_ami_id="ami-087c17d1fe0178315"

#####################################################################################
####################################### ec2_mod #####################################

#----------------------------------------------------------------------------------------
#ec2 instance

enable_instance = false #Set true to deploy instance
ami = {east1 = "ami-087c17d1fe0178315", east2 = "ami-00dfe2c7ce89a450b", west-1="ami-011996ff98de391d1",west-2="ami-0c2d06d50ce30b442"}
instanceType = "t2.micro"
index =0
region = "us-east-1"


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



#####################################################################################
####################################### fsx Windows #################################


    mod_fsx_win_capacity=300 #minimum value
    mod_fsx_win_throughtput_capacity =1024 #minimum value
    mod_fsx_vpc_cidr = "10.0.0.0/16"
    mod_fsx_win_subids=["10.0.1.0/24","10.0.0.0/24"]
    fsx_win_sub_az = [ "us-east-1a","us-east-1b" ]
   

    mod_serv_directory_name = "corp.notexamplearul.com"
    mod_serv_directory_password="newpass@123"
    mod_serv_directory_size="Small"
    mod_serv_directory_type="MicrosoftAD"
  

#####################################################################################
####################################### fsx Lustre #################################

  mod_fsx_lustre_capacity=1200 #minimum value
  
  fsx_lus_vpc_cidr             = "10.0.0.0/16"
  fsx_lus_sub_cidr             = "10.0.1.0/24"




#####################################################################################################################################################
#----------------------------------------------------------------------------------------------------------
#-----------------------------------------------ncd--------------------------------------------------------

#INTERNET GATEWAT TFVARS

vpc_cidr_ncd = "10.0.0.0/18"
pub_cidr = "10.0.0.0/24"
cidr_rt = "0.0.0.0/0"


#----------------------------------------------------------------------------------------------------------------------------------------

#NAT GATEWAY TFVARS

priv_cidr = "10.0.1.0/24"

#----------------------------------------------------------------------------------------------------------------------------------------

#ROUTE53 HEALTH CHECK TFVARS

hc_name = false
fqdn = false
port = 80
resource_path = false
failure_threshold = "3"
request_interval = "30"
protocol_type = "HTTP"
sns_topic = ""
namespace = "AWS/Route53"
metric_name = "HealthCheckStatus"
comparison_operator = "LessThanThreshold"
evaluation_periods = "1"
period = "60"
statistic = "Minimum"
threshold = "1"
unit = "None"
treat_missing_data = "breaching"

#----------------------------------------------------------------------------------------------------------------------------------------

#ROUTE53 RECORDS TFVARS


record_enabled = true
r53_rec_name = "www"
set_identifier = null
multivalue_answer_routing_policy = null
allow_overwrite = false
zone_name = "rishiabcd.com"
values = "10.0.0.27"
alias = {}
ttl = 3600
record_type = "A"


#####################################################################################
####################################### Elastic Beanstalk ###########################


    mod_ebs_name                     = "ebs_app_new"
    mod_ebs_application_version_name = "ebs_application_version_1"
    mod_app_version_source           = "./module/ELASTIC_BEANSTALK/app_example.zip" 

#####################################################################################
####################################### NLB #########################################

mod_nlb_enable_deletion_protection      = false
aws_network_lb_name                     = "network-lb-tf"
mod_nlb_type                            = "network"
mod_nlb_vpc_cidr                        = "10.0.0.0/16"
mod_nlb_subnet_count                    = 2
mod_nlb_public_subnet_cidr              = ["10.0.0.0/24","10.0.1.0/24"]
mod_nlb_vpc_sub_az                      = ["us-east-1a","us-east-1b"]
private_ip_EIPS                         = ["10.0.0.12","10.0.0.11"]
mod_nlb_listener_rule_priority          = 100




#####################################################################################
####################################### DYNAMO DB ###################################



    billing_mode                = "PAY_PER_REQUEST"
    db_name                     = "DB_1"
    hash_key                    = "UserId"
    range_key                   = "key2"
    read_capacity               = 20
    write_capacity              = 20
    stream_enabled_dynamodb     = true
    stream_view_type_dynamodb   ="NEW_AND_OLD_IMAGES"

    ttl_attribute_name  ="TimeToExist"
    ttl_enable = false



#####################################################################################
####################################### DAX #########################################


    dax_cluster_name        = "cluster-example"
    dax_replication_factor  = 2 #should be equal to number of AZ given  
    dax_node_type           = "dax.r4.large"
    dax_az                  = ["us-east-1a","us-east-1b"]





#####################################################################################
####################################### ACM #########################################


    acm_domain_name = "example435terrform.com"
    acm_validation_method = "EMAIL"

#####################################################################################
####################################### KMS #########################################

    kms_key_desc = "KMS key 1"
    kms_key_deletion_window = 10
    kms_key_usage = "ENCRYPT_DECRYPT"
    kms_key_spec = "SYMMETRIC_DEFAULT"
    kms_key_enabled = true
    kms_key_rotation = false
    kms_key_alias = "my-key-alias"

#####################################################################################
####################################### ebs_mod #####################################

ebs_availability_zone = "us-east-1a"
ebs_encrypted = true
ebs_size = 40
ebs_snap = "true"
ebs_dlm_policy_interval          =24
ebs_dlm_policy_interval_unit     ="HOURS"
ebs_dlm_policy_times             =["23:45"]
ebs_dlm_policy_retain_count      =14


#####################################################################################
####################################### s3_mod #####################################

s3_log-acl = "log-delivery-write"
s3_bucket-acl = "public-read"
s3_static-website = "index.html"
s3_enabled = true
s3_life-cycle-enabled = true


#####################################################################################
####################################### rds_mod #####################################

#--------------------------------------------------Main-Instance---------------------------------------------------------------------------------------
rds_main_allocated_storage = 10
rds_main_backup_retention_period = 35
rds_main_db_instance_name = "mdbjain"
rds_main_db_password = "dheeraj05"
rds_main_engine_name = "postgres"
rds_main_family = {
    "mysql" = "mysql8.0",
    "sqlserver-ex" = "sqlserver-ex-15.0",
    "sqlserver-web" = "sqlserver-web-15.0",
    "sqlserver-se" = "sqlserver-se-15.0",
    "sqlserver-ee" = "sqlserver-ee-15.0",
    "postgres" = "postgres13",
    "oracle-se2" = "oracle-se2-19"
}
rds_main_instance_class = "db.t3.small"
rds_main_license_model = {
    "mysql" = "",
    "sqlserver-ex" = "license-included",
    "sqlserver-web" = "license-included"
    "sqlserver-se" = "license-included"
    "sqlserver-ee" = "license-included"
    "postgres" = "",
    "oracle-se2" = "license-included"
}
rds_main_parameter_group = "testparameter"
rds_main_subnet_group = "testsubnet"

#-------------------------------------------Same-Region-Read-Replica-----------------------------------------------------------------------------------

same_region = false
rds_rr_instance_class = "db.t3.small"
rds_rr_size = 10

#------------------------------------------Cross-Region-Read-Replica-----------------------------------------------------------------------------------

cross_region = true
rds_crr_instance_class = "db.t3.small"
rds_crr_parameter_group = "testcrrparameter"
rds_crr_region = "ap-south-1"
rds_crr_size = 10
rds_crr_subnet_group = "testcrrsubnet"

#####################################################################################
####################################### iam_mod #####################################

iam_name = "user-1"
iam_force_destroy = false
iam_pgp_key = "keybase:d3_jain"
iam_password_reset_required = true
iam_password_length = 8
iam_permissions_boundary = ""
iam_custom_policy_name = "testmodule"
iam_custom_policy_description = "Testing Module"
iam_aws_new_group = "Developers"
iam_policy_data = {
  actions   = "s3:ListAllMyBuckets"
  resources = "arn:aws:s3:::*"
  effect    = "Allow"
}
iam_assume_role_pol = "assume-rolepol"
iam_assume_roles = [ "arn:aws:iam::448269213100:role/aws-service-role/support.amazonaws.com/AWSServiceRoleForSupport" ]
iam_group_users = [ "user-1" ]
iam_assumable_role_group_name = "abcde"
iam_policyTwo = "testpolicy"
iam_role_name = "role1"
iam_role_groupname = "Group1"
iam_iamarnname = "iamarngroupname"
