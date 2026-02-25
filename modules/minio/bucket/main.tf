terraform {
  required_version = ">= 1.9.0, <= 1.14.6"

  required_providers {
    # https://registry.terraform.io/providers/aminueza/minio/latest/docs
    minio = {
      source  = "aminueza/minio"
      version = "3.21.0"
    }
  }
}

# https://registry.terraform.io/providers/aminueza/minio/latest/docs/resources/s3_bucket
resource "minio_s3_bucket" "main" {
  # required fields
  bucket = var.config.metadata.name
  # optional fields
  acl = can(var.config.spec.acl) ? var.config.spec.acl : "private"
  # bucket_prefix (String) Prefix of the bucket
  # force_destroy (Boolean) Force destroy the bucket (default: false)
  object_locking = can(var.config.spec.locking) ? var.config.spec.locking : false
  # quota (Number) Quota of the bucket
}
