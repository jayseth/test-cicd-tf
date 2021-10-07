
variable "aws_OU_name" {
  description = "Name for the AWS Org unit "  
  
  type = list(string)
}

variable "aws_enabled_policy"{
    description = "List of Enabled policy types for AWS Organization"
    
    type = list(string)
}



variable "enable_acc_sa" {
    description = "To enable the creation of account for Security Account OU"
    default = false
    type = bool
  
}

variable "enable_acc_log" {
    description = "To enable the creation of account for Log Archive OU"
    default = false
     type = bool
  
}

variable "enable_acc_ssa" {
    description = "To enable the creation of account for Shared Services Account OU"
    default = false
     type = bool
  
}


variable "aws_account_Org_usr"{
    description = "name for the organization account"
    default = ["user-3","user-4"]
    type=list(string)  
}

variable "aws_account_Org_usr_email"{
    description = "email for the organization account"
    default = ["av9152@srmist.edu.in","arul_saxena@srmuniv.edu.in"]
    type=list(string)
}

