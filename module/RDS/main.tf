#--------------------------------------------------Main-Instance---------------------------------------------------------------------------------------
provider "aws" {
  alias = "cross_region"
  region = var.rds_crr_region
}
data "aws_availability_zones" "main_available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "primarysubnet" {
    availability_zone = data.aws_availability_zones.main_available.names[0]
    vpc_id     = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "secondarysubnet" {
    availability_zone = data.aws_availability_zones.main_available.names[1]
    vpc_id     = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
}

resource "aws_db_subnet_group" "dbmainsubnet" {
  name       = var.rds_main_subnet_group
  subnet_ids = [aws_subnet.primarysubnet.id,aws_subnet.secondarysubnet.id]
}

resource "aws_db_parameter_group" "dbmainparameter" {
  name   = var.rds_main_parameter_group
  family = lookup(var.rds_main_family,var.rds_main_engine_name,"Error")
}

resource "aws_db_instance" "dbmain" {
  allocated_storage    = var.rds_main_allocated_storage
  backup_retention_period = var.rds_main_backup_retention_period
  engine               = var.rds_main_engine_name
  instance_class       = var.rds_main_instance_class
  license_model = lookup(var.rds_main_license_model, var.rds_main_engine_name, null)
  name                 = var.rds_main_db_name    
  username             = var.rds_main_db_instance_name
  password             = var.rds_main_db_password
  db_subnet_group_name = aws_db_subnet_group.dbmainsubnet.name
  parameter_group_name = aws_db_parameter_group.dbmainparameter.name
  storage_encrypted = true
  skip_final_snapshot  = true
}

#-------------------------------------------Same-Region-Read-Replica-----------------------------------------------------------------------------------

resource "aws_db_instance" "dbrr" {
    count = var.same_region?1:0

    allocated_storage = var.rds_rr_size
    engine = var.rds_main_engine_name
    instance_class = var.rds_rr_instance_class
    name = var.rds_rr_db_name
    password = ""
    vpc_security_group_ids = [aws_vpc.main.default_security_group_id]
    replicate_source_db = aws_db_instance.dbmain.id
    storage_encrypted = true
    skip_final_snapshot = true
}

#------------------------------------------Cross-Region-Read-Replica-----------------------------------------------------------------------------------

data "aws_kms_alias" "rds_crr" {
    provider = aws.cross_region
    name     = "alias/aws/rds"
}

data "aws_availability_zones" "available" {
    provider = aws.cross_region
    state = "available"
}

resource "aws_vpc" "crr" {
    provider = aws.cross_region
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "crrprimarysubnet" {
    provider = aws.cross_region
    availability_zone = data.aws_availability_zones.available.names[0]
    vpc_id     = aws_vpc.crr.id
    cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "crrsecondarysubnet" {
    provider = aws.cross_region
    availability_zone = data.aws_availability_zones.available.names[1]
    vpc_id     = aws_vpc.crr.id
    cidr_block = "10.0.2.0/24"
}

resource "aws_db_subnet_group" "dbcrrsubnet" {
    provider = aws.cross_region
    name       = var.rds_crr_subnet_group
    subnet_ids = [aws_subnet.crrprimarysubnet.id,aws_subnet.crrsecondarysubnet.id]
}

resource "aws_db_parameter_group" "dbcrrparameter" {
    provider = aws.cross_region
    name   = var.rds_crr_parameter_group
    family = lookup(var.rds_main_family,var.rds_main_engine_name,"Error")
}

resource "aws_db_instance" "dbcrr" {
    count = var.cross_region?1:0

    provider = aws.cross_region
    allocated_storage = var.rds_crr_size
    kms_key_id = data.aws_kms_alias.rds_crr.target_key_arn
    engine = var.rds_main_engine_name
    instance_class = var.rds_crr_instance_class
    name = var.rds_crr_db_name
    password = ""
    vpc_security_group_ids = [aws_vpc.crr.default_security_group_id]
    parameter_group_name = var.rds_crr_parameter_group
    db_subnet_group_name = var.rds_crr_subnet_group
    replicate_source_db = aws_db_instance.dbmain.arn
    storage_encrypted = true
    skip_final_snapshot = true
}