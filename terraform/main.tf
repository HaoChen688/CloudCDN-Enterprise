# ---------- 随机后缀，保证桶名全局唯一 ----------
resource "random_id" "suffix" {
  byte_length = 4
}

# ---------- S3 Bucket（私有） ----------
resource "aws_s3_bucket" "site" {
  bucket = "${var.project_name}-site-${random_id.suffix.hex}"
}

resource "aws_s3_bucket_versioning" "site" {
  bucket = aws_s3_bucket.site.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "site" {
  bucket = aws_s3_bucket.site.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "site" {
  bucket                  = aws_s3_bucket.site.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ---------- 上传 index.html 与 error.html（基础内容） ----------
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.site.id
  key          = "index.html"
  source       = "${path.module}/../site/index.html"
  content_type = "text/html; charset=utf-8"
  etag         = filemd5("${path.module}/../site/index.html")
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.site.id
  key          = "error.html"
  source       = "${path.module}/../site/error.html"
  content_type = "text/html; charset=utf-8"
  etag         = filemd5("${path.module}/../site/error.html")
}