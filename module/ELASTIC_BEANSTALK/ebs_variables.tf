

variable "ebs_name" {
    description = "name for the ebs application"
    default = "ebs_app_new"
    type=string
  
}

variable "ebs_application_version_name" {
    description = "name for the ebs application version"
    default = "ebs_application_version_1"
    type= string
}

variable "app_version_source" {
    description = "Source for application version file"
    default = "app_example.zip"
}