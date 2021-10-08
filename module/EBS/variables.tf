variable "ebs_availability_zone" {
  type = string
  description = "Availability Zone of the volume"
}

variable "ebs_encrypted" {
  type = bool
  description = "If true, the disk will be encrypted"
}

variable "ebs_size" {
  type = number
  description = "Size of the volume"
}

variable "ebs_snap" {
  type = string
  description = "Set it to true for snapshot"
}

variable "ebs_dlm_policy_interval" {
    description = "Interval time for every snapshot"
    default = 24
}

variable "ebs_dlm_policy_interval_unit" {
    description = "-Interval unit in hours"
    default = "HOURS"
}

variable "ebs_dlm_policy_times" {
    description = "A list of times in 24 hour clock format that sets when the lifecycle policy should be evaluated."
    default = ["23:45"]
    type=list(string)
}

variable "ebs_dlm_policy_retain_count" {
    description = "retain count for snapshot"
    default = 14
}