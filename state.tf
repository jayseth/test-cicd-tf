terraform{
    backend "s3" {
        bucket = "pipeline-artifact-devjs"#put your bucket name
        encrypt = true
        key = "main/terraform.tfstate"
        region = "us-east-1"#update the region
    }
}


provider "aws" {
  region  = "us-east-1"
}
