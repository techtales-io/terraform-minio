variable "username" {
  description = "The name of the user this bucket is for."
  type        = string
}

variable "acl" {
  /*
  The aminueza/minio Terraform provider does not specify a default value for the bucket ACL.
  If you do not explicitly set an ACL when creating a bucket, the provider will use MinIO's default.
  In MinIO, by default, only the owner has access to the bucket and its contents.
  This is equivalent to the "private" ACL in many systems.
  To change this, you need to explicitly set the ACL when creating the bucket.
  Please refer to the provider's documentation or the MinIO documentation for more information.
  */
  description = "The ACL for the bucket. Must be: private, public-write, public-read, public-read-write, or public."
  type        = string
  default     = "private"

  validation {
    condition     = can(regex("^(private|public-write|public-read|public-read-write|public)$", var.acl))
    error_message = "Invalid ACL. Must be one of: private, public-write, public-read, public-read-write, public."
  }
}
