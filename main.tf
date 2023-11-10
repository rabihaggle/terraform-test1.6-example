
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_prefix}-bucket2"
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}