
variable "dax_cluster_name" {

    description = "Sets the name of the dax cluster"
    
    type = string
  
}
variable "dax_node_type" {

    description = "Sets the compute and memory capacity of the nodes"
    
    type = string
  
}

variable "dax_replication_factor" {

    description = "Sets the number of nodes for DAX cluster"
  
  
}

variable "dax_az" {

    description = "list of availibility zones in which the custers will be formed"
   
    type=list(string)
  
}