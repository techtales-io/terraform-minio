terraform {
  required_version = ">= 1.9.0, <= 1.12.1"

  required_providers {
    # https://registry.terraform.io/providers/aminueza/minio/latest/docs
    minio = {
      source  = "aminueza/minio"
      version = "3.12.0"
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
  name = "${var.config.user}-${var.config.bucket}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      for statement in data.minio_iam_policy_document.main.statement :
      {
        Effect   = "Allow"
        Action   = statement.actions
        Resource = statement.resources
        # Condition = statement.condition
      }
    ]
  })
  # output of data.minio_iam_policy_document.main.json is creating drifts :(
  # policy = data.minio_iam_policy_document.main.json
}

resource "minio_iam_user_policy_attachment" "main" {
  user_name   = var.config.user
  policy_name = minio_iam_policy.main.name
}
