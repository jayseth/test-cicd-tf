terraform{
    backend "s3" {
        bucket = "dheeraj-aws-pipeline-test"#put your bucket name
        encrypt = true
        key = "landingzone/terraform.tfstate"
        region = "ap-south-1"#update the region
    }
}


provider "aws" {
  region  = var.aws_region
}
