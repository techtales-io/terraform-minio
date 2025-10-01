terraform {
  required_version = ">= 1.9.0, <= 1.13.3"

  required_providers {
    # https://registry.terraform.io/providers/aminueza/minio/latest/docs
    minio = {
      source  = "aminueza/minio"
      version = "3.5.2"
    }
    # https://registry.terraform.io/providers/hashicorp/vault/latest/docs
    vault = {
      source  = "hashicorp/vault"
      version = "5.0.0"
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
  path = "infra/minio/iam/user/${minio_iam_user.main.name}"

  data_json = jsonencode({
    "${var.config.metadata.namespace}" = minio_iam_user.main.secret
  })
}
