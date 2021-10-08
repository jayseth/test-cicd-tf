variable "iam_name" {
  description = "Name for the IAM User"
  type = string
}

variable "iam_force_destroy" {
  description = "When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed."
  type        = bool
}

variable "iam_pgp_key" {
  description = "Either a base-64 encoded PGP public key, or a keybase username in the form `keybase:username`. Used to encrypt password and access key. `pgp_key` is required when `create_iam_user_login_profile` is set to `true`"
  type        = string
}

variable "iam_password_reset_required" {
  description = "Whether the user should be forced to reset the generated password on first login."
  type        = bool
  default     = false
}

variable "iam_password_length" {
  description = "The length of the generated password"
  type        = number
}

variable "iam_permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the user."
  type        = string
}

variable "iam_custom_policy_name" {
  type = string
  description = "Name of the Policy"
}

variable "iam_custom_policy_description" {
  type = string
  description = "About the policy"
}

# variable "aws_profile"{
#     description = "AWS_profile"
#     default = "terraform-practice"
#     type = string


# }

variable "iam_aws_new_group" {
    description = "Aws new user"
    type        = string  
}

variable "iam_policy_data" {
    description = "policy for the group"
    type = map(any)
}

variable "iam_assume_role_pol" {
  type = string
  description = "IAM policy name to assume role to another account"
}

variable "iam_assume_roles" {
    description = "List of IAM roles ARNs which can be assumed by the group"
    type        = list(string)
}


variable "iam_group_users" {
    description = "List of IAM users to have in an IAM group which can assumed the role"
    type        = list(string)  
}

variable "iam_assumable_role_group_name" {
  description = "Name of IAM policy and IAM group"
  type        = string
}

variable "iam_policyTwo"{
  description = "Name of the second policy"
  type = string
}


variable "iam_role_name" {
    description = "Name of role"
    type = string
}
variable "iam_role_groupname"{
    description = "Group name "
    type = string
}

variable "iam_iamarnname" {
  type = string
  description = "value"
}