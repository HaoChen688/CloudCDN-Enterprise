# ---------- ACM 证书（仅在配置了自定义域名时创建） ----------
resource "aws_acm_certificate" "cert" {
  count             = var.domain_name == "" ? 0 : 1
  provider          = aws.us_east_1
  domain_name       = local.fqdn
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.project_name}-cert"
  }
}

# 用 Route 53 自动完成 DNS 验证
resource "aws_route53_record" "cert_validation" {
  for_each = var.domain_name == "" ? {} : {
    for dvo in aws_acm_certificate.cert[0].domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id         = var.hosted_zone_id
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
  ttl             = 60
  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "cert" {
  count                   = var.domain_name == "" ? 0 : 1
  provider                = aws.us_east_1
  certificate_arn         = aws_acm_certificate.cert[0].arn
  validation_record_fqdns = [for r in aws_route53_record.cert_validation : r.fqdn]
}