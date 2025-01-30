# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CONFIGURE TERRAFORM
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
terraform {
  required_version = ">=1.5.0"
  required_providers {
    # https://registry.terraform.io/providers/aminueza/minio/latest/docs
    minio = {
      source  = "aminueza/minio"
      version = "3.2.3"
    }
    # https://registry.terraform.io/providers/hashicorp/local/latest/docs
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
    # https://registry.terraform.io/providers/hashicorp/vault/latest/docs
    vault = {
      source  = "hashicorp/vault"
      version = "4.6.0"
    }
  }

  # need to be commented out on 1st run as the backend is initialized in this run
  # !!! ciruclar dependency !!!
  backend "s3" {
    bucket                      = "terraform"
    key                         = "techtales/minio/terraform.tfstate"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true
    skip_s3_checksum            = true
    skip_requesting_account_id  = true
  }
}

# terraform states
resource "minio_iam_user" "terraform" {
  name         = "terraform"
  disable_user = false
}

module "terraform_user_bucket" {
  source   = "./modules/user-bucket"
  username = minio_iam_user.terraform.name
  acl      = "public"
}

# loki logs
resource "minio_iam_user" "loki" {
  name         = "loki"
  disable_user = false
}

module "loki_user_bucket" {
  source   = "./modules/user-bucket"
  username = minio_iam_user.loki.name
  acl      = "public"
}

# thanos backups
resource "minio_iam_user" "thanos" {
  name         = "thanos"
  disable_user = false
}

module "thanos_user_bucket" {
  source   = "./modules/user-bucket"
  username = minio_iam_user.thanos.name
  acl      = "private"
}

# volsync backups
resource "minio_iam_user" "volsync" {
  name         = "volsync"
  disable_user = false
}

module "volsync_bucket" {
  source   = "./modules/bucket"
  name     = "volsync-backups"
  acl      = "private"
  username = minio_iam_user.volsync.name
}

# obsidian-sync
resource "minio_iam_user" "obsidian_sync" {
  name         = "obsidian-sync"
  disable_user = false
}

module "obsidian_sync" {
  source   = "./modules/bucket"
  name     = "obsidian-sync"
  acl      = "private"
  username = minio_iam_user.obsidian_sync.name
}

# cloudnative-pg backups
resource "minio_iam_user" "cloudnative_pg" {
  name         = "cloudnative-pg"
  disable_user = false
}

module "cloudnative_pg_bucket" {
  source   = "./modules/bucket"
  name     = "cloudnative-pg-backups"
  acl      = "public"
  username = minio_iam_user.cloudnative_pg.name
}


# family phone backups
resource "minio_iam_user" "tyriis" {
  name         = "tyriis"
  disable_user = false
}

resource "minio_iam_user" "jazzlyn" {
  name         = "jazzlyn"
  disable_user = false
}

resource "minio_iam_user" "alex" {
  name         = "alex"
  disable_user = false
}

resource "minio_iam_user" "dominik" {
  name         = "dominik"
  disable_user = false
}

resource "minio_iam_group" "parent" {
  name = "parent"
}

resource "minio_iam_group_membership" "parent" {
  name = "parent-group-membership"

  users = [
    minio_iam_user.tyriis.name,
    minio_iam_user.jazzlyn.name,
  ]

  group = minio_iam_group.parent.name
}

resource "minio_iam_group" "child" {
  name = "child"
}

resource "minio_iam_group_membership" "child" {
  name = "child-group-membership"

  users = [
    minio_iam_user.alex.name,
    minio_iam_user.dominik.name,
  ]

  group = minio_iam_group.child.name
}

resource "minio_s3_bucket" "backup" {
  bucket = "backup"
  acl    = "private"
}

resource "minio_s3_bucket" "gitlab_runner_cache" {
  bucket = "gitlab-runner-cache"
  acl    = "public"
}

data "minio_iam_policy_document" "backup" {
  statement {

    sid = "1"

    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::backup/*",
    ]
  }
}

resource "minio_iam_policy" "backup" {
  name   = "backup"
  policy = data.minio_iam_policy_document.backup.json
}

resource "minio_iam_group_policy_attachment" "backup" {
  group_name  = minio_iam_group.parent.name
  policy_name = minio_iam_policy.backup.name
}

resource "minio_iam_group_policy_attachment" "backup_child" {
  group_name  = minio_iam_group.child.name
  policy_name = minio_iam_policy.backup.name
}

data "minio_iam_policy_document" "nils_phone_backup" {
  statement {

    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::backup/nils/phone/*",
    ]
  }
}

resource "minio_iam_policy" "nils_phone_backup" {
  name   = "backup-nils-phone"
  policy = data.minio_iam_policy_document.nils_phone_backup.json
}

resource "minio_iam_user_policy_attachment" "backup" {
  user_name   = minio_iam_user.tyriis.name
  policy_name = minio_iam_policy.nils_phone_backup.name
}

data "minio_iam_policy_document" "backup_jasmin_phone" {
  statement {

    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::backup/jasmin/phone/*",
    ]
  }
}

resource "minio_iam_policy" "backup_jasmin_phone" {
  name   = "backup_jasmin_phone"
  policy = data.minio_iam_policy_document.backup_jasmin_phone.json
}

resource "minio_iam_user_policy_attachment" "backup_jasmin_phone" {
  user_name   = minio_iam_user.jazzlyn.name
  policy_name = minio_iam_policy.backup_jasmin_phone.name
}

data "minio_iam_policy_document" "alex_phone_backup" {
  statement {

    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::backup/alex/phone/*",
    ]
  }
}

resource "minio_iam_policy" "alex_phone_backup" {
  name   = "backup-alex-phone"
  policy = data.minio_iam_policy_document.alex_phone_backup.json
}

resource "minio_iam_user_policy_attachment" "backup_alex_phone" {
  user_name   = minio_iam_user.alex.name
  policy_name = minio_iam_policy.alex_phone_backup.name
}

data "minio_iam_policy_document" "dominik_phone_backup" {
  statement {

    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::backup/dominik/phone/*",
    ]
  }
}

resource "minio_iam_policy" "dominik_phone_backup" {
  name   = "backup-dominik-phone"
  policy = data.minio_iam_policy_document.dominik_phone_backup.json
}

resource "minio_iam_user_policy_attachment" "backup_dominik_phone" {
  user_name   = minio_iam_user.dominik.name
  policy_name = minio_iam_policy.dominik_phone_backup.name
}

# resource "local_sensitive_file" "secret" {
#   content  = minio_iam_user.test.secret
#   filename = "./secret.txt"
# }

# resource "vault_generic_secret" "minio_secret" {
#   path = "secret/minio"

#   data_json = jsonencode({
#     minio_secret = minio_iam_user.test.secret
#   })
# }
