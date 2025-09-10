resource "aws_s3_bucket" "astrogazer_nodejs_s3_bucket" {
  bucket = "astrogazer-nodejs-s3-bucket"

  tags = {
    Name        = var.tag_s3_name
    Environment = var.tag_s3_environment
  }
}
