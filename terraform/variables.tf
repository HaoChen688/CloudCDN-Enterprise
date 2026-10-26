variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "cloudcdn-enterprise"
}

variable "domain_name" {
  description = "Root domain (e.g. mymywebsite.click). Leave empty to skip custom domain."
  type        = string
  default     = ""
}

variable "subdomain" {
  description = "Subdomain (e.g. www). Empty = apex domain"
  type        = string
  default     = "www"
}

variable "hosted_zone_id" {
  description = "Route 53 Hosted Zone ID (required if domain_name is set)"
  type        = string
  default     = ""
}

variable "price_class" {
  description = "CloudFront price class: PriceClass_100 | PriceClass_200 | PriceClass_All"
  type        = string
  default     = "PriceClass_100"
}