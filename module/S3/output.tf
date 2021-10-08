output "bucket-domain" {
  value = aws_s3_bucket.test_bucket.bucket_domain_name
}

output "bucket1_id" {
  value = aws_s3_bucket.log_bucket.id
}

output "bucket2_id" {
  value = aws_s3_bucket.test_bucket.id
}