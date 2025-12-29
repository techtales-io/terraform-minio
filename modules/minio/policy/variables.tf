variable "config" {
  type = object({
    bucket = string
    user   = string
    statements = list(object({
      actions   = list(string)
      resources = list(string)
    }))
  })

  validation {
    condition     = length(var.config.statements) > 0
    error_message = "The statements list must not be empty."
  }

  validation {
    condition     = alltrue(flatten([for stmt in var.config.statements : [for action in stmt.actions : can(regex("^s3:", action))]]))
    error_message = "All actions must start with 's3:'."
  }

  validation {
    condition     = can(regex("^[a-z0-9-.]+$", var.config.bucket)) && var.config.bucket != ""
    error_message = "The bucket name must be a non-empty string."
  }

  validation {
    condition     = alltrue(flatten([for stmt in var.config.statements : [for resource in stmt.resources : can(regex("^arn:aws:s3:::", resource))]]))
    error_message = "All resources must start with 'arn:aws:s3:::'."
  }

  validation {
    condition     = can(regex("^[a-z0-9-.]+$", var.config.user)) && var.config.user != ""
    error_message = "The user name must be a non-empty string."
  }

}
