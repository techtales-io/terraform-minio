<!-- markdownlint-disable MD041 -->
<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD028 -->

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

[![nix][nix-shield]][nix-url]
[![pre-commit][pre-commit-shield]][pre-commit-url]
[![taskfile][taskfile-shield]][taskfile-url]
[![terraform][terraform-shield]][terraform-url]

# Terraform MinIO for techtales.io

MinIO S3 Server Infrastructure as code with Terraform.

<details>
  <summary style="font-size:1.2em;">Table of Contents</summary>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Concept](#concept)
  - [Policy](#policy)
- [Usage](#usage)
- [Code-Style](#code-style)
  - [Terraform](#terraform)
- [Getting Started](#getting-started)
  - [Prerequisties](#prerequisties)
  - [Initialize repository](#initialize-repository)
- [ENV](#env)
- [Terraform docs](#terraform-docs)
  - [Requirements](#requirements)
  - [Providers](#providers)
  - [Modules](#modules)
  - [Resources](#resources)
  - [Inputs](#inputs)
  - [Outputs](#outputs)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->
</details>

## Concept

### Policy

#### Users

Real users will access buckets by the following pattern:

> $BUCKET/$USER/\*

Example: backup/tyriis/android, documents/jazzlyn/

#### Groups

Member of groups will access buckets by the following pattern:

> $BUCKET/$GROUP/\*

Example: documents/techtales/, documents/familly/

#### K8s services and service accounts

K8s services will access buckets by the following pattern:

> $CLUSTER/$SERVICE/\*

Example: k3s.home/node-red/data

ToDo: check if it would be better to create a bucket for each service

## Usage

\*various commands

## Code-Style

### Terraform

#### Best practices

[terraform-best-practices.com][terraform-best-practices]

#### Naming of Terraform resources

- lower-case characters

Pattern: `[a-z_-]+`

## Getting Started

### Prerequisties

- [pre-commit][pre-commit-url]
- [terraform][terraform-url]
- [terraform-docs][terraform-docs]
- [tflint][tflint]
- [tfsec][tfsec]

### Initialize repository

Terraform and pre-commit framework need to get initialized.

```console
task terraform:init
task pre-commit:init
```

## ENV

| Name                    | Description                             |
| ----------------------- | --------------------------------------- |
| `VAULT_TOKEN`           | vault token                             |
| `AWS_ENDPOINT_URL_S3`   | endpoint url for the s3 state backend   |
| `AWS_REGION`            | region for the s3 state backend         |
| `AWS_ACCESS_KEY_ID`     | username for the s3 state backend       |
| `AWS_SECRET_ACCESS_KEY` | password for the s3 state backend       |
| `MINIO_ENDPOINT`        | the minio endpoint FQDN without http(s) |
| `MINIO_USER`            | the minio admin username                |
| `MINIO_PASSWORD`        | the minio admin password                |
| `MINIO_ENABLE_HTTPS`    | should be true                          |

## Terraform docs

<!-- prettier-ignore-start -->
<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.4.1 |
| <a name="requirement_minio"></a> [minio](#requirement\_minio) | 2.0.1 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | 4.2.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_minio"></a> [minio](#provider\_minio) | 2.0.1 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudnative_pg_bucket"></a> [cloudnative\_pg\_bucket](#module\_cloudnative\_pg\_bucket) | ./modules/bucket | n/a |
| <a name="module_loki_user_bucket"></a> [loki\_user\_bucket](#module\_loki\_user\_bucket) | ./modules/user-bucket | n/a |
| <a name="module_terraform_user_bucket"></a> [terraform\_user\_bucket](#module\_terraform\_user\_bucket) | ./modules/user-bucket | n/a |
| <a name="module_thanos_user_bucket"></a> [thanos\_user\_bucket](#module\_thanos\_user\_bucket) | ./modules/user-bucket | n/a |
| <a name="module_volsync_bucket"></a> [volsync\_bucket](#module\_volsync\_bucket) | ./modules/bucket | n/a |

### Resources

| Name | Type |
|------|------|
| [minio_iam_group.child](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_group) | resource |
| [minio_iam_group.parent](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_group) | resource |
| [minio_iam_group_membership.child](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_group_membership) | resource |
| [minio_iam_group_membership.parent](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_group_membership) | resource |
| [minio_iam_group_policy_attachment.backup](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_group_policy_attachment) | resource |
| [minio_iam_group_policy_attachment.backup_child](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_group_policy_attachment) | resource |
| [minio_iam_policy.alex_phone_backup](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_policy) | resource |
| [minio_iam_policy.backup](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_policy) | resource |
| [minio_iam_policy.backup_jasmin_phone](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_policy) | resource |
| [minio_iam_policy.dominik_phone_backup](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_policy) | resource |
| [minio_iam_policy.nils_phone_backup](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_policy) | resource |
| [minio_iam_user.alex](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_user) | resource |
| [minio_iam_user.cloudnative_pg](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_user) | resource |
| [minio_iam_user.dominik](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_user) | resource |
| [minio_iam_user.jazzlyn](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_user) | resource |
| [minio_iam_user.loki](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_user) | resource |
| [minio_iam_user.terraform](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_user) | resource |
| [minio_iam_user.thanos](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_user) | resource |
| [minio_iam_user.tyriis](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_user) | resource |
| [minio_iam_user.volsync](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_user) | resource |
| [minio_iam_user_policy_attachment.backup](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_user_policy_attachment) | resource |
| [minio_iam_user_policy_attachment.backup_alex_phone](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_user_policy_attachment) | resource |
| [minio_iam_user_policy_attachment.backup_dominik_phone](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_user_policy_attachment) | resource |
| [minio_iam_user_policy_attachment.backup_jasmin_phone](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/iam_user_policy_attachment) | resource |
| [minio_s3_bucket.backup](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/s3_bucket) | resource |
| [minio_s3_bucket.gitlab_runner_cache](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/resources/s3_bucket) | resource |
| [minio_iam_policy_document.alex_phone_backup](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/data-sources/iam_policy_document) | data source |
| [minio_iam_policy_document.backup](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/data-sources/iam_policy_document) | data source |
| [minio_iam_policy_document.backup_jasmin_phone](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/data-sources/iam_policy_document) | data source |
| [minio_iam_policy_document.dominik_phone_backup](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/data-sources/iam_policy_document) | data source |
| [minio_iam_policy_document.nils_phone_backup](https://registry.terraform.io/providers/aminueza/minio/2.0.1/docs/data-sources/iam_policy_document) | data source |

### Inputs

No inputs.

### Outputs

No outputs.
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

<!-- Links -->

[terraform-best-practices]: https://www.terraform-best-practices.com/naming
[terraform-docs]: https://github.com/terraform-docs/terraform-docs
[tflint]: https://github.com/terraform-linters/tflint
[tfsec]: https://aquasecurity.github.io/tfsec

<!-- Badges -->

[terraform-shield]: https://img.shields.io/badge/terraform-1.x-844fba?logo=terraform
[terraform-url]: https://www.terraform.io/
[pre-commit-shield]: https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit
[pre-commit-url]: https://github.com/pre-commit/pre-commit
[taskfile-shield]: https://img.shields.io/badge/taskfile-enabled-brightgreen?logo=task
[taskfile-url]: https://taskfile.dev/
[nix-shield]: https://img.shields.io/badge/nix-enabled-brightgreen?logo=nixos
[nix-url]: https://search.nixos.org/packages
