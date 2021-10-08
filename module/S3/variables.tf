variable "s3_log-acl" {
  type = string
  description = "ACL for log bucket"
}

variable "s3_bucket-acl" {
  type = string
  description = "ACL for S3 bucket"
}

variable "s3_static-website" {
  type = string
  description = "Website name"
}

variable "s3_enabled" {
  type = bool
  description = "If true versioning will be enabled"
}

variable "s3_life-cycle-enabled" {
  type = bool
  description = "If true life-cycle will be enabled"
}