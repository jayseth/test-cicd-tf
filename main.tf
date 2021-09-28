module "IAM" {
  source = "./modules/IAM"
}

module "VPC" {
    source = "./modules/VPC"
    cidr_vpc = var.cidr_vpc
}
