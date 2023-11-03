resource "yandex_lockbox_secret" "access_key" {
  description = "Bucket Access Key"
  name = yandex_iam_service_account_static_access_key.sa-static-key.access_key
}

resource "yandex_lockbox_secret" "secret_key" {
  description = "Bucket Secret Key"
  name = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  }

resource "yandex_lockbox_secret" "pg_user" {
  description = "PG user"
  name = var.pg_user
}
resource "yandex_lockbox_secret" "pg_password" {
  description = "PG password"
  name = var.pg_password
}

resource "yandex_lockbox_secret" "pg_database" {
  description = "PG DB"
  name = var.pg_database
}
resource "yandex_lockbox_secret" "kafka_cluster_user" {
  description = "Kafka user"
  name = var.kafka_cluster_user
}

resource "yandex_lockbox_secret" "kafka_cluster_password" {
  description = "Kafka password"
  name = var.kafka_cluster_password
}
