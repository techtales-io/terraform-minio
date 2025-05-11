provider "vault" {
  # ATLANTIS_INJECT_VAULT_CONFIG
}

data "vault_generic_secret" "terraform_minio" {
  path = "infra/techtales/terraform-minio/tyriis.dev"
}

provider "minio" {
  minio_server      = data.vault_generic_secret.terraform_minio.data["minio_server"]
  minio_user        = data.vault_generic_secret.terraform_minio.data["minio_user"]
  minio_password    = data.vault_generic_secret.terraform_minio.data["minio_password"]
  minio_region      = "home"
  minio_api_version = "v4"
  minio_ssl         = true
}
