#####################################################################################
###################################  ECS  ###########################################

variable "cluster_name" {
  description = "Cluster name."
}

variable "name_prefix" {
  description = "A prefix used for naming resources."
  type        = string
}

variable "subnets_ids" {
  description = "IDs of subnets. Use subnets from various availability zones to make the cluster more reliable."
  type        = list(string)
}

variable "task_container_image" {
  description = "The image used to start a container."
  type        = string
}

variable "trusted_cidr_blocks" {
  description = "Trusted subnets e.g. with ALB and bastion host."
  type        = list(string)
}
