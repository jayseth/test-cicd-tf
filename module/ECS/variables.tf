variable "enabled" {
  type        = bool
  description = "Whether to create the resources. Set to `false` to prevent the module from creating any resources"
  default     = true
}

variable "name_prefix" {
  description = "A prefix used for naming resources."
  type        = string
}

variable "container_name" {
  description = "Optional name for the container to be used instead of name_prefix."
  default     = ""
  type        = string
}

variable "task_container_image" {
  description = "The image used to start a container."
  type        = string
}

variable "task_container_port" {
  description = "The port number on the container that is bound to the user-specified or automatically assigned host port"
  type        = number
  default     = 0
}

variable "task_host_port" {
  description = "The port number on the container instance to reserve for your container."
  type        = number
  default     = 0
}

variable "task_definition_cpu" {
  description = "Amount of CPU to reserve for the task."
  default     = 256
  type        = number
}

variable "task_definition_memory" {
  description = "The soft limit (in MiB) of memory to reserve for the task."
  default     = 512
  type        = number
}

variable "task_container_cpu" {
  description = "Amount of CPU to reserve for the container."
  default     = null
  type        = number
}

variable "task_container_memory" {
  description = "The hard limit (in MiB) of memory for the container."
  default     = null
  type        = number
}

variable "task_container_memory_reservation" {
  description = "The soft limit (in MiB) of memory to reserve for the container."
  default     = null
  type        = number
}

variable "task_container_command" {
  description = "The command that is passed to the container."
  default     = []
  type        = list(string)
}

variable "task_container_working_directory" {
  description = "The working directory to run commands inside the container."
  default     = ""
  type        = string
}

variable "task_container_environment" {
  description = "The environment variables to pass to a container."
  default     = {}
  type        = map(string)
}

variable "task_container_secrets" {
  description = "The secrets variables to pass to a container."
  default     = null
  type        = list(map(string))
}

variable "cloudwatch_log_group_name" {
  description = "CloudWatch log group name required to enabled logDriver in container definitions for ecs task."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = map(string)
  default     = {}
}

# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/private-auth.html
variable "repository_credentials" {
  default     = ""
  description = "name or ARN of a secrets manager secret (arn:aws:secretsmanager:region:aws_account_id:secret:secret_name)"
  type        = string
}

variable "repository_credentials_kms_key" {
  default     = "alias/aws/secretsmanager"
  description = "key id, key ARN, alias name or alias ARN of the key that encrypted the repository credentials"
  type        = string
}

variable "create_repository_credentials_iam_policy" {
  default     = false
  description = "Set to true if you are specifying `repository_credentials` variable, it will attach IAM policy with necessary permissions to task role."
}

variable "placement_constraints" {
  type        = list(any)
  description = "(Optional) A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. This is a list of maps, where each map should contain \"type\" and \"expression\""
  default     = []
}

variable "proxy_configuration" {
  type        = list(any)
  description = "(Optional) The proxy configuration details for the App Mesh proxy. This is a list of maps, where each map should contain \"container_name\", \"properties\" and \"type\""
  default     = []
}

variable "volume" {
  description = "(Optional) A set of volume blocks that containers in your task may use. This is a list of maps, where each map should contain \"name\", \"host_path\", \"docker_volume_configuration\" and \"efs_volume_configuration\". Full set of options can be found at https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html"
  default     = []
}

variable "task_health_check" {
  type        = object({ command = list(string), interval = number, timeout = number, retries = number, startPeriod = number })
  description = "An optional healthcheck definition for the task"
  default     = null
}

variable "task_start_timeout" {
  type        = number
  description = "Time duration (in seconds) to wait before giving up on resolving dependencies for a container. If this parameter is not specified, the default value of 3 minutes is used (fargate)."
  default     = null
}

variable "task_stop_timeout" {
  type        = number
  description = "Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own. The max stop timeout value is 120 seconds and if the parameter is not specified, the default value of 30 seconds is used."
  default     = null
}

variable "task_mount_points" {
  description = "The mount points for data volumes in your container. Each object inside the list requires \"sourceVolume\", \"containerPath\" and \"readOnly\". For more information see https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html "
  type        = list(object({ sourceVolume = string, containerPath = string, readOnly = bool }))
  default     = null
}

variable "cluster_name" {
  description = "Cluster name."
}
variable "trusted_cidr_blocks" {
  description = "Trusted subnets e.g. with ALB and bastion host."
  type        = list(string)
}
variable "instance_types" {
  description = "ECS node instance types. Maps of pairs like `type = weight`. Where weight gives the instance type a proportional weight to other instance types."
  type        = map(any)
  default = {
    "t3a.small" = 2
  }
}
variable "protect_from_scale_in" {
  description = "The autoscaling group will not select instances with this setting for termination during scale in events."
  default     = true
}
data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}
variable "spot" {
  description = "Choose should we use spot instances or on-demand to poulate ECS cluster."
  type        = bool
  default     = false
}
variable "security_group_ids" {
  description = "Additional security group IDs. Default security group would be merged with the provided list."
  default     = []
}
variable "subnets_ids" {
  description = "IDs of subnets. Use subnets from various availability zones to make the cluster more reliable."
  type        = list(string)
}
variable "target_capacity" {
  description = "The target utilization for the cluster. A number between 1 and 100."
  default     = "100"
}
variable "user_data" {
  description = "A shell script will be executed at once at EC2 instance start."
  default     = ""
}
variable "ebs_disks" {
  description = "A list of additional EBS disks."
  type        = map(string)
  default     = {}
}
data "aws_subnet" "default" {
  id = local.subnets_ids[0]
}
variable "on_demand_base_capacity" {
  description = "The minimum number of on-demand EC2 instances"
  default     = 0
}


locals {
  vpc_id                  = data.aws_subnet.default.vpc_id
  subnets_ids             = var.subnets_ids
  name                    = replace(var.cluster_name, " ", "_")
  trusted_cidr_blocks     = var.trusted_cidr_blocks
  instance_types          = var.instance_types
  sg_ids                  = distinct(concat(var.security_group_ids, [aws_security_group.ecs_nodes.id]))
  ami_id                  = data.aws_ssm_parameter.ecs_ami.value
  spot                    = var.spot == true ? 0 : 100
  target_capacity         = var.target_capacity
  protect_from_scale_in   = var.protect_from_scale_in
  user_data               = var.user_data == "" ? [] : [var.user_data]
  ebs_disks               = var.ebs_disks
  on_demand_base_capacity = var.on_demand_base_capacity

  tags = {
    Name   = var.cluster_name,
    Module = "ECS Cluster"
  }
}
