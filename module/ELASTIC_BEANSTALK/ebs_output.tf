output "aws_ebs_app_name" {

    value = aws_elastic_beanstalk_application.ebs_application.name
  
}

output "aws_ebs_id" {

    value = aws_elastic_beanstalk_application.ebs_application.id
  
}

output "aws_S3_bucket_arn" {

    value = aws_s3_bucket.default.arn
}

output "aws_ebs_app_version_name" {

    value = aws_elastic_beanstalk_application_version.version_ebs.name
  
}

output "aws_ebs_app_version_key" {

    value = aws_elastic_beanstalk_application_version.version_ebs.key
  
}