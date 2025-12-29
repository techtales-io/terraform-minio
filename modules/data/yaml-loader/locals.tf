locals {
  # Function to read and decode YAML files
  manifests = {
    for v in fileset("${path.root}/../../data", "**/*.yaml") :
    v => yamldecode(file("${path.root}/../../data/${v}"))
    if try(yamldecode(file("${path.root}/../../data/${v}")).metadata.namespace, "") == var.namespace
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

  # Filter and re-structure permission policies - group by user+bucket
  policies_grouped = {
    for v in local.manifests :
    v.metadata.name => {
      user = v.metadata.name
      permissions_by_bucket = {
        for permission in try(v.spec.permissions, []) :
        permission.bucket => permission...
      }
    }
    if v.kind == "MinioUser" && try(length(v.spec.permissions), 0) > 0
  }

  # Flatten into policy objects with multiple statements per user+bucket combination
  policies = merge(flatten([
    for user_name, user_data in local.policies_grouped : [
      for bucket_name, permissions in user_data.permissions_by_bucket : {
        "policy_${user_name}_${bucket_name}" = {
          bucket = bucket_name
          user   = user_name
          statements = [
            for permission in permissions : {
              actions   = [for action in permission.actions : "s3:${action}"]
              resources = ["arn:aws:s3:::${bucket_name}${permission.path}"]
            }
          ]
        }
      }
    ]
  ])...)

}
