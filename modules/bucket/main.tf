terraform {
  required_version = ">=1.5.0"
  required_providers {
    minio = {
      # https://registry.terraform.io/providers/aminueza/minio/latest/docs
      source  = "aminueza/minio"
      version = "3.2.0"
    }
  }
}

resource "minio_s3_bucket" "bucket" {
  bucket = var.name
  acl    = var.acl
}

data "minio_iam_policy_document" "bucket" {
  statement {

    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::${var.name}/*",
    ]
  }
}

resource "minio_iam_policy" "bucket" {
  name   = var.username
  policy = data.minio_iam_policy_document.bucket.json
}

resource "minio_iam_user_policy_attachment" "bucket" {
  user_name   = var.username
  policy_name = minio_iam_policy.bucket.name
}
