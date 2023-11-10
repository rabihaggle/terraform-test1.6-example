
variable "bucket_prefix" {
  type    = string
  default = "test"
}
## -> https://medium.com/@smburrows/terraform-workspace-variables-497535bf645e
locals {
  workspace_path = "./workspaces/${terraform.workspace}.yaml"
  defaults       = file("./workspaces/default.yaml")
  workspace      = fileexists(local.workspace_path) ? file(local.workspace_path) : yamlencode({})
  settings = merge(
    yamldecode(local.defaults),
    yamldecode(local.workspace)
  )
}
output "project_settings" {
  value = local.settings
}