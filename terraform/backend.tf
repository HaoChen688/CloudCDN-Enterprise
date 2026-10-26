terraform {
  backend "s3" {
    # 具体值通过 -backend-config 注入
    encrypt = true
    key     = "cloudcdn/terraform.tfstate"
    region  = "us-east-1"
  }
}