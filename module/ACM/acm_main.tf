resource "aws_acm_certificate" "example" {
  domain_name       =  var.acm_domain_name 
  validation_method = var.acm_validation_method
}

#########################################
# Use this if validation method is EMAIL
/*
resource "aws_acm_certificate_validation" "example" {
  certificate_arn = aws_acm_certificate.example.arn
}

*/

###############################################################################################################
#  DNS Validation with Route 53. Make sure the Route 53 zone is Available and Validation method is selected as DNS

/*
data "aws_route53_zone" "example" {
  name         = "example.com"
  private_zone = false
}

resource "aws_route53_record" "example" {
  for_each = {
    for dvo in aws_acm_certificate.example.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.example.zone_id
}

resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.example.arn
  validation_record_fqdns = [for record in aws_route53_record.example : record.fqdn]
}

*/