resource "yandex_kubernetes_node_group" "kube_node_conf" {
  cluster_id  = "${yandex_kubernetes_cluster.zonal_cluster_kubernetes.id}"
  name        = var.kube_node_name
  count       = length(var.kube_node_conf)
  description = "node group for k8s cluster"
  version     = var.kube_version

  timeouts {
    create = "${var.tf_timeouts["create"]}"
    update = "${var.tf_timeouts["update"]}"
    delete = "${var.tf_timeouts["delete"]}"
  }

  labels = {
    "environment.type" = var.kube_node_conf[count.index].type
  }

  node_labels = {
    "environment.type" = var.kube_node_conf[count.index].type
  }

  instance_template {
    platform_id = var.kube_node_conf[count.index].platform_id

    container_runtime {
      type = "containerd"
    }

    network_interface {
      nat        = true
      subnet_ids = ["${yandex_vpc_subnet.b.id}"]
#      security_group_ids = [
#        yandex_vpc_security_group.k8s-main-sg.id,
#        yandex_vpc_security_group.k8s-public-services.id
#      ]
    }

    resources {
      memory = var.kube_node_conf[count.index].ram
      cores  = var.kube_node_conf[count.index].cpu
    }

    boot_disk {
      type = "network-ssd"
      size = var.kube_node_conf[count.index].size
    }

    scheduling_policy {
      preemptible = false
    }
  }

  scale_policy {
    auto_scale {
      min     = 1
      max     = 2
      initial = 1
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-b"
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      day        = "saturday"
      start_time = "4:00"
      duration   = "3h"
    }
  }
}