#Creating EBS Appliation , Also managing the serive roles

resource "aws_elastic_beanstalk_application" "ebs_application" {
  name        = var.ebs_name
  

  appversion_lifecycle {
    service_role          = aws_iam_role.beanstalk_service.arn
    max_count             = 128
    delete_source_from_s3 = true
  }
}


# Creating a bucket with random name
resource "aws_s3_bucket" "default" {
  bucket = "${random_pet.pet_name.id}-bucket"
}


# Creating a S3 bucket object with the application version (app_example.zip is the application version)
resource "aws_s3_bucket_object" "obj_bucket" {
  bucket = aws_s3_bucket.default.id
  key    = "beanstalk/app_example.zip"
  source = var.app_version_source
}

# Creating the Application version for EBS 
resource "aws_elastic_beanstalk_application_version" "version_ebs" {
  name        = var.ebs_application_version_name
  application = aws_elastic_beanstalk_application.ebs_application.name
  description = "application version created by terraform"
  bucket      = aws_s3_bucket.default.id
  key         = aws_s3_bucket_object.obj_bucket.id
}





# random name generator
resource "random_pet" "pet_name" {
  length    = 3
  separator = "-"
}

