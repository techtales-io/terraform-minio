locals {
  # Function to read and decode YAML files
  manifests = {
    for v in fileset("${path.root}/../data", "**/*.yaml") :
    v => yamldecode(file("${path.root}/../data/${v}"))
  }

  # Filter and ogranize server(s)
  buckets = {
    for v in local.manifests :
    v.metadata.name => v
    if v.kind == "MinioBucket"
  }

  # Filter and organize categories
  users = {
    for v in local.manifests :
    v.metadata.name => v
    if v.kind == "MinioUser"
  }

  # Filter and re-structure permission policies
  policies = merge(flatten([
    for v in local.manifests :
    v.kind == "MinioUser" ? [
      {
        for permission in v.spec.permissions :
        "policy_${v.metadata.name}_${permission.bucket}" => {
          bucket    = permission.bucket
          user      = v.metadata.name
          actions   = [for action in permission.actions : "s3:${action}"]
          resources = ["arn:aws:s3:::${permission.bucket}${permission.path}"]
        }
      }
    ] : []
  ])...)

}
