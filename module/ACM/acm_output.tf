output "acm_certificate_arn" {

    value = aws_acm_certificate.example.arn

  
}

output "acm_certificate_domain" {

    value = aws_acm_certificate.example.domain_name
  
}