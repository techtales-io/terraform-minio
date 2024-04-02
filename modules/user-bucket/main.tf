terraform {
  required_version = ">=1.5.0"
  required_providers {
    minio = {
      # https://registry.terraform.io/providers/aminueza/minio/latest/docs
      source  = "aminueza/minio"
      version = "2.0.1"
    }
  }
}

resource "minio_s3_bucket" "user_bucket" {
  bucket = var.username
  acl    = var.acl
}

data "minio_iam_policy_document" "user_bucket" {
  statement {

    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::${var.username}/*",
    ]
  }
}

resource "minio_iam_policy" "user_bucket" {
  name   = var.username
  policy = data.minio_iam_policy_document.user_bucket.json
}

resource "minio_iam_user_policy_attachment" "user_bucket" {
  user_name   = var.username
  policy_name = minio_iam_policy.user_bucket.name
}
