
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_prefix}-bucket"
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}

resource "aws_s3_bucket" "bucket2" {
  bucket = "${var.bucket_prefix}-bucket2"
}

output "bucket_name2" {
  value = aws_s3_bucket.bucket2.bucket
}




