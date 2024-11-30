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
      acl         = string
      locking     = optional(bool)
    })
  })

  validation {
    condition     = var.config.apiVersion == "terraform.techtales.io/v1alpha1"
    error_message = "The api must be `terraform.techtales.io` in version `v1alpha1`."
  }

  validation {
    condition     = var.config.kind == "MinioBucket"
    error_message = "The kind must be 'MinioBucket'."
  }

  validation {
    condition     = can(regex("^[a-z0-9-.]+$", var.config.metadata.name)) && var.config.metadata.name != ""
    error_message = "The metadata.name must be a non-empty string."
  }

  validation {
    condition     = can(index(["private", "public-write", "public-read", "public-read-write", "public"], var.config.spec.acl))
    error_message = "The acl must be one of the following values: private, public-write, public-read, public-read-write, public."
  }

}
