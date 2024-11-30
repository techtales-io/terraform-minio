variable "config" {
  type = object({
    apiVersion = string
    kind       = string
    metadata = object({
      name      = string
      namespace = optional(string)
    })
    spec = object({
      description = optional(string)
      disabled    = optional(bool)
      permissions = optional(list(object({
        path    = string
        actions = list(string)
      })))
    })
  })

  validation {
    condition     = var.config.apiVersion == "terraform.techtales.io/v1alpha1"
    error_message = "The api must be `terraform.techtales.io` in version `v1alpha1`."
  }

  validation {
    condition     = var.config.kind == "MinioUser"
    error_message = "The kind must be 'MinioUser'."
  }

  validation {
    condition     = can(regex("^[a-z0-9-.]+$", var.config.metadata.name)) && var.config.metadata.name != ""
    error_message = "The metadata.name must be a non-empty string."
  }
}
