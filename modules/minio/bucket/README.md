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

## Providers

| Name | Version |
|------|---------|
| <a name="provider_minio"></a> [minio](#provider\_minio) | 2.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [minio_s3_bucket.main](https://registry.terraform.io/providers/aminueza/minio/2.5.1/docs/resources/s3_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config"></a> [config](#input\_config) | n/a | <pre>object({<br/>    apiVersion = string<br/>    kind       = string<br/>    metadata = object({<br/>      name      = string<br/>      namespace = optional(string)<br/>    })<br/>    spec = object({<br/>      description = optional(string)<br/>      acl         = string<br/>      locking     = optional(bool)<br/>    })<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_data"></a> [data](#output\_data) | n/a |
<!-- END_TF_DOCS -->

<!-- prettier-ignore-end -->
