resource "yandex_mdb_kafka_cluster" "kafka_cluster_simple" {
  name        = var.kafka_cluster_name
  environment = "PRODUCTION"
  network_id  = "${yandex_vpc_network.prod-net.id}"
  subnet_ids  = ["${yandex_vpc_subnet.b.id}"]

  timeouts {
    create = "${var.tf_timeouts["create"]}"
    update = "${var.tf_timeouts["update"]}"
    delete = "${var.tf_timeouts["delete"]}"
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "SAT"
    hour = 3
  }

  config {
    version          = "3.5"
    brokers_count    = 1
    zones            = ["ru-central1-b"]
    assign_public_ip = false
    schema_registry  = false


    kafka {
      resources {
        resource_preset_id = "b3-c1-m4"
        disk_type_id       = "network-ssd"
        disk_size          = 32

      }

      kafka_config {
        compression_type                = "COMPRESSION_TYPE_ZSTD"
#        log_flush_interval_messages     = 1024
#        log_flush_interval_ms           = 1000
#        log_flush_scheduler_interval_ms = 1000
#        log_retention_bytes             = 1073741824
#        log_retention_hours             = 168
#        log_retention_minutes           = 10080
#        log_retention_ms                = 86400000
#        log_segment_bytes               = 134217728
#        log_preallocate                 = true
#        num_partitions                  = 10
#        default_replication_factor      = 1
#        message_max_bytes               = 1048588
#        replica_fetch_max_bytes         = 1048576
#        ssl_cipher_suites               = ["TLS_DHE_RSA_WITH_AES_128_CBC_SHA", "TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256"]
#        offsets_retention_minutes       = 10080
#        sasl_enabled_mechanisms         = ["SASL_MECHANISM_SCRAM_SHA_256", "SASL_MECHANISM_SCRAM_SHA_512"]
      }
    }
  }
}

resource "yandex_mdb_kafka_topic" events {
  cluster_id         = yandex_mdb_kafka_cluster.kafka_cluster_simple.id
  for_each = toset(var.kafka_cluster_topics_name)
  name               = "${each.key}"
  partitions         = 1
  replication_factor = 1

  timeouts {
    create = "${var.tf_timeouts["create"]}"
    update = "${var.tf_timeouts["update"]}"
    delete = "${var.tf_timeouts["delete"]}"
  }
}

resource "yandex_mdb_kafka_user" user_events {
  cluster_id = yandex_mdb_kafka_cluster.kafka_cluster_simple.id
  name       = var.kafka_cluster_user
  password   = var.kafka_cluster_password

  permission {
    topic_name = "*"
    role       = "ACCESS_ROLE_ADMIN"
  }
}