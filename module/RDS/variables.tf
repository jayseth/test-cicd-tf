#--------------------------------------------------Main-Instance---------------------------------------------------------------------------------------
variable "rds_main_allocated_storage" {
  type = number
  default = 20
}

variable "rds_main_backup_retention_period" {
  type = number
  description = "Number of days to retain the backup"
}

variable "rds_main_db_instance_name" {
  type = string
  description = "DB master username. Size of name should be less than 8"
}

variable "rds_main_db_name" {
  type = string
  description = "DB name when created. Length of thename should be less than 8"
  default = ""
}

variable "rds_main_db_password" {
  type = string
  description = "DB Password. Password size should be minimum 8"
}

variable "rds_main_engine_name" {
  type = string
  description = "Database Engine Type"
}

variable "rds_main_family" {
  description = "Engine name with family "
  type = map(any)
}

variable "rds_main_instance_class" {
  type = string
  description = "Instance class of the db"
}

variable "rds_main_license_model" {
  type = map(any)
  description = "license_model for specific engine"
}

variable "rds_main_parameter_group" {
  type = string
  description = "Parameter Group Name"
}

variable "rds_main_subnet_group" {
  type = string
  description = "Subnet Group Name"
}

#-------------------------------------------Same-Region-Read-Replica-----------------------------------------------------------------------------------

variable "same_region" {
  type = bool
  description = "Set it to true if you want a same region replica"
}

variable "rds_rr_db_name" {
  type = string
  description = "DB name"
  default = ""
}

variable "rds_rr_instance_class" {
  type = string
  description = "Compatible instance class"
}

variable "rds_rr_size" {
  type = number
  description = "Size of the DB"
}

#------------------------------------------Cross-Region-Read-Replica-----------------------------------------------------------------------------------

variable "cross_region" {
  type = bool
  description = "Set it to true if you want a cross region replica"
}

variable "rds_crr_db_name" {
  type = string
  description = "DB name"
  default = ""
}

variable "rds_crr_instance_class" {
  type = string
  description = "Compatible instance class"
}

variable "rds_crr_parameter_group" {
  type = string
  description = "Parameter Group Name"
}

variable "rds_crr_region" {
  type = string
  description = "Service Region"
}

variable "rds_crr_size" {
  type = number
  description = "Size of the DB"
}

variable "rds_crr_subnet_group" {
  type = string
  description = "Subnet Group Name"
}