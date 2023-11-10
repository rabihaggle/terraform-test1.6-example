data "aws_availability_zones" "this" {}
output "aws_availability_zones" {
  value = data.aws_availability_zones.this
}
data "aws_region" "current" {}

output "aws_region" {
  value = data.aws_region.current
}
