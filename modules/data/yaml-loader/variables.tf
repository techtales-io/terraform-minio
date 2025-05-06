variable "namespace" {
  type        = string
  description = "The namespace to use for the YAML loader."

  validation {
    condition     = can(regex("^[a-z0-9-.]+$", var.namespace))
    error_message = "The namespace must match ^[a-z0-9-.]+$."
  }

  validation {
    condition     = var.namespace != ""
    error_message = "The namespace must not be empty."
  }
}
