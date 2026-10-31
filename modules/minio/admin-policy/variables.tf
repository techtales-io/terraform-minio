variable "config" {
  type = object({
    apiVersion = string
    kind       = string
    metadata = object({
      name      = string
      namespace = optional(string)
    })
    spec = object({
      user        = string
      description = optional(string)
      statements = list(object({
        actions   = list(string)
        resources = list(string)
      }))
    })
  })

  validation {
    condition     = var.config.apiVersion == "terraform.techtales.io/v1alpha1"
    error_message = "The api must be `terraform.techtales.io` in version `v1alpha1`."
  }

  validation {
    condition     = var.config.kind == "MinioAdminPolicy"
    error_message = "The kind must be 'MinioAdminPolicy'."
  }

  validation {
    condition     = can(regex("^[a-z0-9-.]+$", var.config.metadata.name)) && var.config.metadata.name != ""
    error_message = "The metadata.name must be a non-empty string."
  }

  validation {
    condition     = length(var.config.spec.statements) > 0
    error_message = "The statements list must not be empty."
  }

  # this kind exists for server level administration, bucket scoped access belongs to the policy module
  validation {
    condition     = alltrue(flatten([for stmt in var.config.spec.statements : [for action in stmt.actions : can(regex("^admin:", action))]]))
    error_message = "All actions must start with 'admin:'."
  }

  validation {
    condition     = alltrue(flatten([for stmt in var.config.spec.statements : [for resource in stmt.resources : can(regex("^arn:aws:s3:::", resource))]]))
    error_message = "All resources must start with 'arn:aws:s3:::'."
  }

  validation {
    condition     = can(regex("^[a-z0-9-.]+$", var.config.spec.user)) && var.config.spec.user != ""
    error_message = "The user name must be a non-empty string."
  }
}
