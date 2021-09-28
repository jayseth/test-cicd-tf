module "IAM" {
  source = "./modules/IAM"
}

module "VPC" {
    source = "./modules/VPC"
    cidr = var.cidr
}
