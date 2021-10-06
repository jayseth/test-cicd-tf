#####
# Execution IAM Role
#####
resource "aws_iam_role" "execution" {
  count = var.enabled ? 1 : 0

  name               = "${var.name_prefix}-execution-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attach" {
  count = var.enabled ? 1 : 0

  role       = aws_iam_role.execution[0].name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy" "read_repository_credentials" {
  count = var.create_repository_credentials_iam_policy && var.enabled ? 1 : 0

  name   = "${var.name_prefix}-read-repository-credentials"
  role   = aws_iam_role.execution[0].id
  policy = data.aws_iam_policy_document.read_repository_credentials[0].json
}

#####
# IAM - Task role, basic. Append policies to this role for S3, DynamoDB etc.
#####
resource "aws_iam_role" "task" {
  count = var.enabled ? 1 : 0

  name               = "${var.name_prefix}-task-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  tags = var.tags
}

resource "aws_iam_role_policy" "log_agent" {
  count = var.enabled ? 1 : 0

  name   = "${var.name_prefix}-log-permissions"
  role   = aws_iam_role.task[0].id
  policy = data.aws_iam_policy_document.task_permissions.json
}

#####
# ECS task definition
#####

locals {
  task_environment = [
    for k, v in var.task_container_environment : {
      name  = k
      value = v
    }
  ]
}

resource "aws_ecs_task_definition" "task" {
  count = var.enabled ? 1 : 0

  family                   = var.name_prefix
  execution_role_arn       = aws_iam_role.execution[0].arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_definition_cpu
  memory                   = var.task_definition_memory
  task_role_arn            = aws_iam_role.task[0].arn

  container_definitions = <<EOF
[{
    "name": "${var.container_name != "" ? var.container_name : var.name_prefix}",
    "image": "${var.task_container_image}",
    %{if var.repository_credentials != ""~}
    "repositoryCredentials": {
      "credentialsParameter": "${var.repository_credentials}"
    },
    %{~endif}
    "essential": true,
    %{if var.task_container_port != 0 || var.task_host_port != 0~}
    "portMappings": [
      {
        %{if var.task_host_port != 0~}
        "hostPort": ${var.task_host_port},
        %{~endif}
        %{if var.task_container_port != 0~}
        "containerPort": ${var.task_container_port},
        %{~endif}
        "protocol":"tcp"
      }
    ],
    %{~endif}
    %{if var.cloudwatch_log_group_name != ""~}
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${var.cloudwatch_log_group_name}",
        "awslogs-region": "${data.aws_region.current.name}",
        "awslogs-stream-prefix": "container"
      }
    },
    %{~endif}
    %{if var.task_health_check != null~}
    "healthcheck": {
        "command": ${jsonencode(var.task_health_check.command)},
        "interval": ${var.task_health_check.interval},
        "timeout": ${var.task_health_check.timeout},
        "retries": ${var.task_health_check.retries},
        "startPeriod": ${var.task_health_check.startPeriod}
    },
    %{~endif}
    "command": ${jsonencode(var.task_container_command)},
    %{if var.task_container_working_directory != ""~}
    "workingDirectory": ${jsonencode(var.task_container_working_directory)},
    %{~endif}
    %{if var.task_container_memory != null~}
    "memory": ${var.task_container_memory},
    %{~endif}
    %{if var.task_container_memory_reservation != null~}
    "memoryReservation": ${var.task_container_memory_reservation},
    %{~endif}
    %{if var.task_container_cpu != null~}
    "cpu": ${var.task_container_cpu},
    %{~endif}
    %{if var.task_start_timeout != null~}
    "startTimeout": ${var.task_start_timeout},
    %{~endif}
    %{if var.task_stop_timeout != null~}
    "stopTimeout": ${var.task_stop_timeout},
    %{~endif}
    %{if var.task_mount_points != null~}
    "mountPoints": ${jsonencode(var.task_mount_points)},
    %{~endif}
    %{if var.task_container_secrets != null~}
    "secrets": ${jsonencode(var.task_container_secrets)},
    %{~endif}
    "environment": ${jsonencode(local.task_environment)}
}]
EOF

  dynamic "placement_constraints" {
    for_each = var.placement_constraints
    content {
      expression = lookup(placement_constraints.value, "expression", null)
      type       = placement_constraints.value.type
    }
  }

  dynamic "proxy_configuration" {
    for_each = var.proxy_configuration
    content {
      container_name = proxy_configuration.value.container_name
      properties     = lookup(proxy_configuration.value, "properties", null)
      type           = lookup(proxy_configuration.value, "type", null)
    }
  }

  dynamic "volume" {
    for_each = var.volume
    content {
      name      = volume.value.name
      host_path = lookup(volume.value, "host_path", null)

      dynamic "docker_volume_configuration" {
        for_each = lookup(volume.value, "docker_volume_configuration", [])
        content {
          scope         = lookup(docker_volume_configuration.value, "scope", null)
          autoprovision = lookup(docker_volume_configuration.value, "autoprovision", null)
          driver        = lookup(docker_volume_configuration.value, "driver", null)
          driver_opts   = lookup(docker_volume_configuration.value, "driver_opts", null)
          labels        = lookup(docker_volume_configuration.value, "labels", null)
        }
      }

      dynamic "efs_volume_configuration" {
        for_each = lookup(volume.value, "efs_volume_configuration", [])
        content {
          file_system_id          = lookup(efs_volume_configuration.value, "file_system_id", null)
          root_directory          = lookup(efs_volume_configuration.value, "root_directory", null)
          transit_encryption      = lookup(efs_volume_configuration.value, "transit_encryption", null)
          transit_encryption_port = lookup(efs_volume_configuration.value, "transit_encryption_port", null)

          dynamic "authorization_config" {
            for_each = length(lookup(efs_volume_configuration.value, "authorization_config")) == 0 ? [] : [lookup(efs_volume_configuration.value, "authorization_config", {})]
            content {
              access_point_id = lookup(authorization_config.value, "access_point_id", null)
              iam             = lookup(authorization_config.value, "iam", null)
            }
          }
        }
      }
    }
  }

  tags = merge(
    var.tags,
    {
      Name = var.container_name != "" ? var.container_name : var.name_prefix
    }
  )
}

resource "aws_ecs_cluster" "default" {
  name               = local.name
  capacity_providers = [aws_ecs_capacity_provider.asg.name, "FARGATE", "FARGATE_SPOT"]
  tags               = local.tags

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.asg.name
    weight = 1
  }
}

resource "aws_ecs_capacity_provider" "asg" {
  name = aws_autoscaling_group.ecs_nodes.name

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs_nodes.arn
    managed_termination_protection = local.protect_from_scale_in ? "ENABLED" : "DISABLED"

    managed_scaling {
      maximum_scaling_step_size = 10
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = local.target_capacity
    }
  }
}

// Allow EC2 instance to register as ECS cluster member, fetch ECR images, write logs to CloudWatch
data "aws_iam_policy_document" "ec2_instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2_instance_role" {
  assume_role_policy = data.aws_iam_policy_document.ec2_instance_assume_role_policy.json
  name               = "EcsCluster${local.name}Ec2InstanceRole"
  tags               = local.tags
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ssm_core_role" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ecs_node" {
  name = "EcsCluster${local.name}Ec2InstanceProfiles"
  role = aws_iam_role.ec2_instance_role.name
}

// Allow ECS service to interact with LoadBalancers
data "aws_iam_policy_document" "ecs_service_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_service_role" {
  assume_role_policy = data.aws_iam_policy_document.ecs_service_role_policy.json
  name               = "EcsCluster${local.name}ServiceRole"
  tags               = local.tags
}

resource "aws_iam_role_policy_attachment" "service_role" {
  role       = aws_iam_role.ecs_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

data "aws_iam_policy_document" "ecs_task_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_role" {
  assume_role_policy = data.aws_iam_policy_document.ecs_task_role_policy.json
  name               = "EcsCluster${local.name}DefaultTaskRole"
  tags               = local.tags
}

resource "aws_iam_role_policy_attachment" "default_task_role" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "allow_create_log_groups" {
  statement {
    actions   = ["logs:CreateLogGroup"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "allow_create_log_groups" {
  policy = data.aws_iam_policy_document.allow_create_log_groups.json
  role   = aws_iam_role.ecs_task_role.id
}

data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = <<EOT
#!/bin/bash
echo ECS_CLUSTER="${local.name}" >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_SPOT_INSTANCE_DRAINING=${tostring(var.spot)} >> /etc/ecs/ecs.config

EOT
  }

  dynamic "part" {
    for_each = local.user_data
    content {
      content_type = "text/x-shellscript"
      content      = part.value
    }
  }
}

resource "aws_launch_template" "node" {
  name_prefix            = "ecs_node_"
  image_id               = local.ami_id
  instance_type          = "t3a.small"
  vpc_security_group_ids = local.sg_ids
  user_data              = data.template_cloudinit_config.config.rendered
  tags                   = local.tags
  update_default_version = true

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_node.name
  }

  dynamic "block_device_mappings" {
    for_each = local.ebs_disks
    content {
      device_name = block_device_mappings.key

      ebs {
        volume_size = block_device_mappings.value
      }
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags          = local.tags
  }

  tag_specifications {
    resource_type = "volume"
    tags          = local.tags
  }
}