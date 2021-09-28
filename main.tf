module "IAM" {
  source = "./modules/IAM"
}

module "VPC" {
    source = "./modules/VPC"
    cidr_block_vpc = var.cidr_vpc
}
