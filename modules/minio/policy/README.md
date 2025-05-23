<!-- markdownlint-disable MD041 -->
<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD028 -->

# TF DOCS

<!-- prettier-ignore-start -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0, <= 1.11.4 |
| <a name="requirement_minio"></a> [minio](#requirement\_minio) | 3.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_minio"></a> [minio](#provider\_minio) | 3.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [minio_iam_policy.main](https://registry.terraform.io/providers/aminueza/minio/3.4.0/docs/resources/iam_policy) | resource |
| [minio_iam_user_policy_attachment.main](https://registry.terraform.io/providers/aminueza/minio/3.4.0/docs/resources/iam_user_policy_attachment) | resource |
| [minio_iam_policy_document.main](https://registry.terraform.io/providers/aminueza/minio/3.4.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config"></a> [config](#input\_config) | n/a | <pre>object({<br/>    actions   = list(string)<br/>    bucket    = string<br/>    resources = list(string)<br/>    user      = string<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_data"></a> [data](#output\_data) | n/a |
<!-- END_TF_DOCS -->

<!-- prettier-ignore-end -->
