

variable "fsx_win_capacity" {
    description = "fsx windows file system capacity"
    default = 300
  
}

variable "fsx_win_throughtput_capacity" {

    description = "fsx windows file system throughtput capacity"
    default = 1024
  
}

variable "fsx_vpc_cidr" {
    description = "vpc id for fsx windows directory"
    type=string
  
}

variable "fsx_win_subids" {

    description = "list of subnet ids for the fsx windows file system"
    type=list(string)
  
}

variable "fsx_win_sub_az" {
    description = "sets the AZ for subnets"
    type = list(string)
  
}

variable "serv_directory_name" {
    description ="service directory name"
    type = string
  
}

variable "serv_directory_password" {
    description = "service directory password"
     type = string
  
}

variable "serv_directory_size" {
  
  description = "service directory size"
   type = string
}

variable "serv_directory_type" {
    description = "service directory type"
     type = string
  
}
