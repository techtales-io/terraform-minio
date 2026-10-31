output "data" {
  value = {
    users          = local.users
    buckets        = local.buckets
    policies       = local.policies
    admin_policies = local.admin_policies
    manifests      = local.manifests
  }
}
