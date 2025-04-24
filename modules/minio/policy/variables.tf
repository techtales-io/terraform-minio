variable "config" {
  type = object({
    actions   = list(string)
    bucket    = string
    resources = list(string)
    user      = string
  })

  validation {
    condition     = length(var.config.actions) > 0
    error_message = "The actions list must not be empty."
  }

  validation {
    condition     = alltrue([for action in var.config.actions : can(regex("^s3:", action))])
    error_message = "All actions must start with 's3:'."
  }

  validation {
    condition     = can(regex("^[a-z0-9-.]+$", var.config.bucket)) && var.config.bucket != ""
    error_message = "The bucket name must be a non-empty string."
  }

  validation {
    condition     = length(var.config.resources) > 0
    error_message = "The resources list must not be empty."
  }

  validation {
    condition     = alltrue([for resource in var.config.resources : can(regex("^arn:aws:s3:::", resource))])
    error_message = "All resources must start with 'arn:aws:s3:::'."
  }

  validation {
    condition     = can(regex("^[a-z0-9-.]+$", var.config.user)) && var.config.user != ""
    error_message = "The bucket name must be a non-empty string."
  }

}
