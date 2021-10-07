

variable "fsx_lustre_capacity" {
    description = "fsx lustre file system capacity"
    default = 1200
  
}


variable "fsx_lus_vpc_cidr" {

        description = "fsx lustre vpc cidr"
        type = string
      
}

variable "fsx_lus_sub_cidr" {

        description = "fsx lustre subnet cidr"
        type = string
      
}