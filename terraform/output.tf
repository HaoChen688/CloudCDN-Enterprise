output "s3_bucket_name" {
  value = aws_s3_bucket.site.id
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.cdn.id
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cdn.domain_name
}

output "site_url" {
  value = var.domain_name == "" ? "https://${aws_cloudfront_distribution.cdn.domain_name}" : "https://${local.fqdn}"
}