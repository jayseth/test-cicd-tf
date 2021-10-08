output "oai_id" {

    value = aws_cloudfront_origin_access_identity.new_id.id
  
}

output "oai_iam_arn" {

    value = aws_cloudfront_origin_access_identity.new_id.iam_arn
  
}

output "s3_canonical_user_id" {

    value = aws_cloudfront_origin_access_identity.new_id.s3_canonical_user_id
  
}

output "cloudfront_access_identity_path" {

    value = aws_cloudfront_origin_access_identity.new_id.cloudfront_access_identity_path
  
}