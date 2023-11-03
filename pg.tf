resource "yandex_mdb_postgresql_user" "dbuser" {
  cluster_id = yandex_mdb_postgresql_cluster.database.id
  name       = var.pg_user
  password   = var.pg_password
  conn_limit = 50
  settings = {
    default_transaction_isolation = "read committed"
    log_min_duration_statement    = 5000
  }
}

resource "yandex_mdb_postgresql_cluster" "database" {
  name        = var.pg_cluster_name
  environment = "PRODUCTION"
  network_id  = yandex_vpc_network.prod-net.id
#  security_group_ids = [yandex_vpc_security_group.DataBase-access-rules.id]
  deletion_protection = false

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
    version = 14
    resources {
      resource_preset_id = "c3-c2-m4"
      disk_type_id       = "network-ssd"
      disk_size          = 100
    }
  }

  host {
    zone      = "ru-central1-b"
    subnet_id = yandex_vpc_subnet.b.id
    assign_public_ip = true
  }
}

resource "yandex_mdb_postgresql_database" "pg_database" {
  cluster_id = yandex_mdb_postgresql_cluster.database.id
  name       = var.pg_database
  owner      = var.pg_user

  timeouts {
    create = "${var.tf_timeouts["create"]}"
    update = "${var.tf_timeouts["update"]}"
    delete = "${var.tf_timeouts["delete"]}"
  }
}
