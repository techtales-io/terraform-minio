terraform {
  required_version = ">= 1.10.0, <= 1.14.4"

  required_providers {
    # https://registry.terraform.io/providers/aminueza/minio/latest/docs
    minio = {
      source  = "aminueza/minio"
      version = "3.14.0"
    }
    # https://registry.terraform.io/providers/hashicorp/vault/latest/docs
    vault = {
      source  = "hashicorp/vault"
      version = "5.6.0"
    }
  }
}

resource "minio_iam_user" "main" {
  # required fields
  name = var.config.metadata.name
  # optional fields
  disable_user = can(var.config.spec.disabled) ? var.config.spec.disabled : false
  # force_destroy = false # currently not implemented
  # secret = "secret" # currently not implemented
  tags = {
    managed-by = "terraform"
  }
  # update_secret = false # currently not implemented
}


resource "vault_generic_secret" "minio_secret" {
  path = "infra/minio/iam/${var.config.metadata.namespace}/${minio_iam_user.main.name}"

  data_json = jsonencode({
    "AWS_ACCESS_KEY_ID"     = minio_iam_user.main.name
    "AWS_SECRET_ACCESS_KEY" = minio_iam_user.main.secret
  })
}
