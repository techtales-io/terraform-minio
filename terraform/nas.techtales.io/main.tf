# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CONFIGURE TERRAFORM
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
terraform {
  required_version = ">= 1.9.0, <= 1.14.4"
  required_providers {
    # https://registry.terraform.io/providers/aminueza/minio/latest/docs
    minio = {
      source  = "aminueza/minio"
      version = "3.15.0"
    }
    # https://registry.terraform.io/providers/hashicorp/vault/latest/docs
    vault = {
      source  = "hashicorp/vault"
      version = "5.6.0"
    }
  }
}

module "yaml" {
  source    = "../../modules/data/yaml-loader"
  namespace = "nas.techtales.io"
}

module "users" {
  for_each = module.yaml.data.users
  source   = "../../modules/minio/user"
  config   = each.value
}

module "buckets" {
  for_each = module.yaml.data.buckets
  source   = "../../modules/minio/bucket"
  config   = each.value
}

module "bucket_policies" {
  depends_on = [module.buckets, module.users]
  for_each   = module.yaml.data.policies
  source     = "../../modules/minio/policy"
  config     = each.value
}

###### replication test

resource "minio_s3_bucket_replication" "terraform" {
  bucket = module.buckets["terraform"].data.bucket


  rule {
    delete_replication          = true
    delete_marker_replication   = true
    existing_object_replication = true
    metadata_sync               = true

    target {
      bucket          = "terraform"
      secure          = true
      host            = data.vault_generic_secret.terraform_minio.data["replication_server"]
      bandwidth_limit = "1000M"
      access_key      = data.vault_generic_secret.terraform_minio.data["replication_user"]
      secret_key      = data.vault_generic_secret.terraform_minio.data["replication_password"]
    }
  }

  depends_on = [
    module.buckets["terraform"]
  ]
}
