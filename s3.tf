resource "aws_s3_bucket" "wontech" {
    bucket = "my-first-bucket"
    acl = "private"
    tags = {
      "name" = "bmo"
      "environment" = "production"
    }
  
}