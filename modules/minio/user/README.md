<!-- markdownlint-disable MD041 -->
<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD028 -->

# TF DOCS

<!-- prettier-ignore-start -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0, <= 1.10.5 |
| <a name="requirement_minio"></a> [minio](#requirement\_minio) | 2.5.1 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | 4.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_minio"></a> [minio](#provider\_minio) | 2.5.1 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 4.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [minio_iam_user.main](https://registry.terraform.io/providers/aminueza/minio/2.5.1/docs/resources/iam_user) | resource |
| [vault_generic_secret.minio_secret](https://registry.terraform.io/providers/hashicorp/vault/4.4.0/docs/resources/generic_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config"></a> [config](#input\_config) | n/a | <pre>object({<br/>    apiVersion = string<br/>    kind       = string<br/>    metadata = object({<br/>      name      = string<br/>      namespace = optional(string)<br/>    })<br/>    spec = object({<br/>      description = optional(string)<br/>      disabled    = optional(bool)<br/>      permissions = optional(list(object({<br/>        path    = string<br/>        actions = list(string)<br/>      })))<br/>    })<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_data"></a> [data](#output\_data) | n/a |
<!-- END_TF_DOCS -->

<!-- prettier-ignore-end -->
