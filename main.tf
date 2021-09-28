module "IAM" {
  source = "./modules/IAM"
}

module "VPC" {
    source = "./modules/VPC"
    cidr_block = var.cidr_vpc
}
