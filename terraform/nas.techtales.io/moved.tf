# Buckets
moved {
  from = minio_s3_bucket.backup
  to   = module.buckets["backup"].minio_s3_bucket.main
}

moved {
  from = module.cloudnative_pg_bucket.minio_s3_bucket.bucket
  to   = module.buckets["cnpg"].minio_s3_bucket.main
}

moved {
  from = module.loki_user_bucket.minio_s3_bucket.user_bucket
  to   = module.buckets["loki"].minio_s3_bucket.main
}

moved {
  from = module.terraform_user_bucket.minio_s3_bucket.user_bucket
  to   = module.buckets["terraform"].minio_s3_bucket.main
}

moved {
  from = module.thanos_user_bucket.minio_s3_bucket.user_bucket
  to   = module.buckets["thanos"].minio_s3_bucket.main
}

moved {
  from = module.volsync_bucket.minio_s3_bucket.bucket
  to   = module.buckets["volsync"].minio_s3_bucket.main
}

# Users
moved {
  from = minio_iam_user.cloudnative_pg
  to   = module.users["cnpg"].minio_iam_user.main
}

moved {
  from = minio_iam_user.jazzlyn
  to   = module.users["jazzlyn"].minio_iam_user.main
}

moved {
  from = minio_iam_user.loki
  to   = module.users["loki"].minio_iam_user.main
}

moved {
  from = minio_iam_user.terraform
  to   = module.users["terraform"].minio_iam_user.main
}

moved {
  from = minio_iam_user.thanos
  to   = module.users["thanos"].minio_iam_user.main
}

moved {
  from = minio_iam_user.tyriis
  to   = module.users["tyriis"].minio_iam_user.main
}

moved {
  from = minio_iam_user.volsync
  to   = module.users["volsync"].minio_iam_user.main
}

# Policies
moved {
  from = module.cloudnative_pg_bucket.minio_iam_policy.bucket
  to   = module.bucket_policies["policy_cnpg_cnpg"].minio_iam_policy.main
}

moved {
  from = module.loki_user_bucket.minio_iam_policy.user_bucket
  to   = module.bucket_policies["policy_loki_loki"].minio_iam_policy.main
}

moved {
  from = module.terraform_user_bucket.minio_iam_policy.user_bucket
  to   = module.bucket_policies["policy_terraform_terraform"].minio_iam_policy.main
}

moved {
  from = module.thanos_user_bucket.minio_iam_policy.user_bucket
  to   = module.bucket_policies["policy_thanos_thanos"].minio_iam_policy.main
}

moved {
  from = module.volsync_bucket.minio_iam_policy.bucket
  to   = module.bucket_policies["policy_volsync_volsync"].minio_iam_policy.main
}

# Policy attachments
moved {
  from = module.cloudnative_pg_bucket.minio_iam_user_policy_attachment.bucket
  to   = module.bucket_policies["policy_cnpg_cnpg"].minio_iam_user_policy_attachment.main
}

moved {
  from = module.loki_user_bucket.minio_iam_user_policy_attachment.user_bucket
  to   = module.bucket_policies["policy_loki_loki"].minio_iam_user_policy_attachment.main
}

moved {
  from = module.terraform_user_bucket.minio_iam_user_policy_attachment.user_bucket
  to   = module.bucket_policies["policy_terraform_terraform"].minio_iam_user_policy_attachment.main
}

moved {
  from = module.thanos_user_bucket.minio_iam_user_policy_attachment.user_bucket
  to   = module.bucket_policies["policy_thanos_thanos"].minio_iam_user_policy_attachment.main
}

moved {
  from = module.volsync_bucket.minio_iam_user_policy_attachment.bucket
  to   = module.bucket_policies["policy_volsync_volsync"].minio_iam_user_policy_attachment.main
}
