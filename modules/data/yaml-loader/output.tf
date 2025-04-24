output "data" {
  value = {
    users    = local.users
    buckets  = local.buckets
    policies = local.policies
  }
}
