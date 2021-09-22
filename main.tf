module "IAM" {
  source = "./modules/IAM"
}

module "VPC" {
    source = "./modules/VPC"
}