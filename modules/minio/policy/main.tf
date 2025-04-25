terraform {
  required_version = ">= 1.9.0, <= 1.10.5"

  required_providers {
    # https://registry.terraform.io/providers/aminueza/minio/latest/docs
    minio = {
      source  = "aminueza/minio"
      version = "2.5.1"
    }
  }
}

data "minio_iam_policy_document" "main" {
  statement {
    actions   = var.config.actions
    resources = var.config.resources
  }
}

resource "minio_iam_policy" "main" {
  name   = "${var.config.user}-${var.config.bucket}"
  policy = data.minio_iam_policy_document.main.json
}

resource "minio_iam_user_policy_attachment" "main" {
  user_name   = var.config.user
  policy_name = minio_iam_policy.main.name
}
