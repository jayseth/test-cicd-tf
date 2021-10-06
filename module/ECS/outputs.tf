output "task_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the ECS service role."
  value       = join("", aws_iam_role.task.*.arn)
}

output "task_role_name" {
  description = "The name of the Fargate task service role."
  value       = join("", aws_iam_role.task.*.name)
}

output "task_role_create_date" {
  description = "The creation date of the IAM role."
  value       = join("", aws_iam_role.task.*.create_date)
}

output "task_role_id" {
  description = "The ID of the role."
  value       = join("", aws_iam_role.task.*.id)
}

output "task_role_unique_id" {
  description = "The stable and unique string identifying the role."
  value       = join("", aws_iam_role.task.*.unique_id)
}

output "execution_role_arn" {
  description = "The Amazon Resource Name (ARN) of execution role."
  value       = join("", aws_iam_role.execution.*.arn)
}

output "execution_role_name" {
  description = "The name of the execution service role."
  value       = join("", aws_iam_role.execution.*.name)
}

output "execution_role_create_date" {
  description = "The creation date of the IAM role."
  value       = join("", aws_iam_role.execution.*.create_date)
}

output "execution_role_id" {
  description = "The ID of the execution role."
  value       = join("", aws_iam_role.execution.*.id)
}

output "execution_role_unique_id" {
  description = "The stable and unique string identifying the role."
  value       = join("", aws_iam_role.execution.*.unique_id)
}

output "task_definition_arn" {
  description = "Full ARN of the Task Definition (including both family and revision)."
  value       = join("", aws_ecs_task_definition.task.*.arn)
}

output "task_definition_family" {
  description = "The family of the Task Definition."
  value       = join("", aws_ecs_task_definition.task.*.family)
}

output "task_definition_revision" {
  description = "The revision of the task in a particular family."
  value       = join("", aws_ecs_task_definition.task.*.revision)
}

output "container_port" {
  description = "Port on which the container is listening."
  value       = var.task_container_port
}

output "name" {
  value = aws_ecs_cluster.default.name
}

output "id" {
  value = aws_ecs_cluster.default.id
}

output "ecs_service_role_name" {
  value = aws_iam_role.ecs_service_role.name
}

output "ecs_service_role_arn" {
  value = aws_iam_role.ecs_service_role.arn
}

output "ecs_default_task_role_name" {
  value = aws_iam_role.ecs_task_role.name
}

output "ecs_default_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}

output "iam_instance_profile_arn" {
  value = aws_iam_instance_profile.ecs_node.arn
}

output "iam_instance_profile_name" {
  value = aws_iam_instance_profile.ecs_node.name
}

output "security_group_id" {
  value = aws_security_group.ecs_nodes.id
}

output "security_group_name" {
  value = aws_security_group.ecs_nodes.name
}

output "iam_instance_role_name" {
  value = aws_iam_role.ec2_instance_role.name
}

output "arn" {
  value = aws_ecs_cluster.default.arn
}

output "capacity_provider_name" {
  value = aws_ecs_capacity_provider.asg.name
}
