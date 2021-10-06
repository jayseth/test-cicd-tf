module "ECS" {

    source = "./module/ECS"

    cluster_name = var.cluster_name
    name_prefix = var.name_prefix
    subnets_ids = var.subnets_ids
    task_container_image = var.task_container_image
    trusted_cidr_blocks = var.trusted_cidr_blocks
}
