<!-- markdownlint-disable MD041 -->
<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD028 -->
<!-- markdownlint-disable MD060 -->

# TF DOCS

<!-- prettier-ignore-start -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0, <= 1.14.3 |
| <a name="requirement_minio"></a> [minio](#requirement\_minio) | 3.12.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | 5.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_minio"></a> [minio](#provider\_minio) | 3.12.0 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 5.6.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket_policies"></a> [bucket\_policies](#module\_bucket\_policies) | ../../modules/minio/policy | n/a |
| <a name="module_buckets"></a> [buckets](#module\_buckets) | ../../modules/minio/bucket | n/a |
| <a name="module_users"></a> [users](#module\_users) | ../../modules/minio/user | n/a |
| <a name="module_yaml"></a> [yaml](#module\_yaml) | ../../modules/data/yaml-loader | n/a |

## Resources

| Name | Type |
|------|------|
| [minio_s3_bucket_replication.terraform](https://registry.terraform.io/providers/aminueza/minio/3.12.0/docs/resources/s3_bucket_replication) | resource |
| [vault_generic_secret.terraform_minio](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/data-sources/generic_secret) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->

<!-- prettier-ignore-end -->
