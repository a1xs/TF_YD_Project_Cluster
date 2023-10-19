output "access_key" {
  description = "Bucket Access Key"
  value       = yandex_iam_service_account_static_access_key.sa-static-key.access_key
}

output "secret_key" {
  description = "Bucket Secret Key"
  value       = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  sensitive = true
}

output "yandex_iam_service_account" {
  description = "Create SA for same services"
  value       = yandex_iam_service_account_static_access_key.sa-static-key.created_at
}

output "yandex_kms_symmetric_key" {
  description = "Symetric key Yandex KMS for services"
  value       = yandex_kms_symmetric_key.key-services.created_at
}