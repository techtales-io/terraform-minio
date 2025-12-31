<!-- markdownlint-disable MD041 -->
<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD028 -->
<!-- markdownlint-disable MD060 -->

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

[![taskfile][taskfile-shield]][taskfile-url]
[![pre-commit][pre-commit-shield]][pre-commit-url]
[![renovate][renovate-shield]][renovate-url]
[![terraform][terraform-shield]][terraform-url]
[![Remote State file][statefile-shield]](README.md)

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

- [task][taskfile-url]
- [mise][mise-url]

### Initialize repository

Install dependencies with mise

```console
mise install
```

Terraform and pre-commit framework need to get initialized.

```console
task terraform:init
task pre-commit:init
```

## ENV

| Name                    | Description                             |
| ----------------------- | --------------------------------------- |
| `VAULT_TOKEN`           | vault token (not required for atlantis) |
| `VAULT_ADDR`            | the vault address                       |
| `AWS_ENDPOINT_URL_S3`   | endpoint url for the s3 state backend   |
| `AWS_REGION`            | region for the s3 state backend         |
| `AWS_ACCESS_KEY_ID`     | username for the s3 state backend       |
| `AWS_SECRET_ACCESS_KEY` | password for the s3 state backend       |

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

<!-- Links -->

[terraform-best-practices]: https://www.terraform-best-practices.com/naming
[mise-url]: https://mise.jdx.dev/

<!-- Badges -->

[terraform-shield]: https://img.shields.io/badge/terraform-1.x-844fba?logo=terraform
[terraform-url]: https://www.terraform.io/
[pre-commit-shield]: https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit
[pre-commit-url]: https://github.com/pre-commit/pre-commit
[taskfile-shield]: https://img.shields.io/badge/taskfile-enabled-brightgreen?logo=task
[taskfile-url]: https://taskfile.dev/
[renovate-shield]: https://img.shields.io/badge/renovate-enabled-brightgreen?logo=renovate
[renovate-url]: https://www.whitesourcesoftware.com/free-developer-tools/renovate/
[statefile-shield]: https://img.shields.io/badge/minio-tfstate-C72E49?logo=minio&logoColor=C72E49
