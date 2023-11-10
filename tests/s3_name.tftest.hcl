# valid_string_concat.tftest.hcl


run "valid_string_concat" {

  command = plan

  assert {
    condition     = aws_s3_bucket.bucket.bucket == "${var.bucket_prefix}-bucket"
    error_message = "S3 bucket name did not match expected"
  }

}
