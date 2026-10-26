# ---------- Route 53：A 记录（Alias）指向 CloudFront ----------
resource "aws_route53_record" "cdn_alias" {
  count   = var.domain_name == "" ? 0 : 1
  zone_id = var.hosted_zone_id
  name    = local.fqdn
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

# IPv6
resource "aws_route53_record" "cdn_alias_ipv6" {
  count   = var.domain_name == "" ? 0 : 1
  zone_id = var.hosted_zone_id
  name    = local.fqdn
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}