# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CONFIGURE TERRAFORM
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
terraform {
  required_version = ">= 1.9.0, <= 1.14.3"
  required_providers {
    # https://registry.terraform.io/providers/aminueza/minio/latest/docs
    minio = {
      source  = "aminueza/minio"
      version = "3.12.0"
    }
    # https://registry.terraform.io/providers/hashicorp/vault/latest/docs
    vault = {
      source  = "hashicorp/vault"
      version = "5.0.0"
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
