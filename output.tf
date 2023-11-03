output "yandex_iam_service_account" {
  description = "Create SA for same services"
  value       = yandex_iam_service_account_static_access_key.sa-static-key.created_at
}

output "yandex_iam_service_account_id" {
  description = "Create SA for same services"
  value       = yandex_iam_service_account_static_access_key.sa-static-key.id
}

output "yandex_kms_symmetric_key" {
  description = "Symetric key Yandex KMS for services"
  value       = yandex_kms_symmetric_key.key-services.created_at
}

output "yandex_storage_bucket1" {
  description = "Yandex Bucket-1 service"
  value       = yandex_storage_bucket.storage1.bucket
}

output "yandex_storage_bucket1_id" {
  description = "Yandex Bucket-2 service"
  value       = yandex_storage_bucket.storage1.id
}

output "yandex_storage_bucket2" {
  description = "Yandex Bucket-2 service"
  value       = yandex_storage_bucket.storage2.bucket
}

output "yandex_storage_bucket2_id" {
  description = "Yandex Bucket-2 service"
  value       = yandex_storage_bucket.storage2.id
}

output "yandex_kubernetes_cluster" {
  description = "Yandex Kubernetes Cluster (Master)service"
  value       = yandex_kubernetes_cluster.zonal_cluster_kubernetes.created_at
}

output "yandex_kubernetes_cluster_id" {
  description = "Yandex Kubernetes Cluster ID"
  value       = yandex_kubernetes_cluster.zonal_cluster_kubernetes.id
}

output "yandex_kubernetes_node_group" {
  description = "Yandex Kubernetes Cluster (Node)service"
  value       = yandex_kubernetes_node_group.kube_node_conf[*].created_at
}

output "yandex_mdb_postgresql_cluster" {
  description = "Yandex Postgress Cluster service"
  value       = yandex_mdb_postgresql_cluster.database.created_at
}

output "yandex_mdb_postgresql_cluster_id" {
  description = "Yandex Postgress Cluster service"
  value       = yandex_mdb_postgresql_cluster.database.id
}

output "yandex_mdb_kafka_cluster" {
  description = "Yandex Kafka Cluster service"
  value       = yandex_mdb_kafka_cluster.kafka_cluster_simple.created_at
}

output "yandex_mdb_kafka_cluster_id" {
  description = "Yandex Kafka Cluster service"
  value       = yandex_mdb_kafka_cluster.kafka_cluster_simple.id
}

#output "yandex_mdb_kafka_topic" {
#  description = "Yandex Kafka topics"
#  value       = <<-EOT
#    Kafka topic name: ${yandex_mdb_kafka_topic.events[*].name}
#  EOT
#}
