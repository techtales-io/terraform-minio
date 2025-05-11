config {
  force = false
  disabled_by_default = false
}

rule "terraform_module_pinned_source" {
  enabled = true
  style = "flexible"
  default_branches = ["main", "master", "default", "develop"]
}

rule "terraform_deprecated_interpolation" {
  enabled = false
  # needed to disable this rule because module ignore does not work as expected
  # ignore_modules = {
  #   "modules/minio/user" = true
  # }
}
