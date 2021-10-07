output "File_System_ID" {

  value = aws_fsx_lustre_file_system.fsx_lustre.id
}

output "S3_bucket_arn" {

    value = aws_s3_bucket.default.arn
  
}

output "vpc_id" {

    value = aws_vpc.main.id
  
}

output "subnet_id" {

    value = aws_subnet.fsx_lustre_sub.id
  
}