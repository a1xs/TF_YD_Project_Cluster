resource "yandex_kubernetes_cluster" "zonal_cluster_kubernetes" {
  name        = var.kube_cluster_name
  description = "Zonal cluster for project"

  network_id = "${yandex_vpc_network.prod-net.id}"

  master {
    version = var.kube_version
    zonal {
      zone      = "${yandex_vpc_subnet.b.zone}"
      subnet_id = "${yandex_vpc_subnet.b.id}"
    }

    public_ip = true

#    security_group_ids = [
#      yandex_vpc_security_group.k8s-main-sg.id,
#      yandex_vpc_security_group.k8s-master-whitelist.id
#    ]

    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        day        = "saturday"
        start_time = "3:00"
        duration   = "3h"
      }
    }

    master_logging {
      enabled = true
#      log_group_id = "${yandex_logging_group.log_group.id}"
      kube_apiserver_enabled = true
      cluster_autoscaler_enabled = true
      events_enabled = true
      audit_enabled = true
    }
  }

  service_account_id      = "${yandex_iam_service_account.sa.id}"
  node_service_account_id = "${yandex_iam_service_account.sa.id}"

  labels = {
    my_key       = "my_value"
    my_other_key = "my_other_value"
  }

  release_channel = "STABLE"
  network_policy_provider = "CALICO"

  kms_provider {
    key_id = "${yandex_kms_symmetric_key.key-services.id}"
  }
}

resource "yandex_logging_group" "log_group" {
  name      = "logging-group-project"
}