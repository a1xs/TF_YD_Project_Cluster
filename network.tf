resource "yandex_vpc_network" "prod-net" {
  name = "golden-cut-network"

  timeouts {
    delete = "${var.tf_timeouts["delete"]}"
  }
}

resource "yandex_vpc_subnet" "a" {
  name           = "gc-subnet-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.prod-net.id
  v4_cidr_blocks = ["10.0.1.0/24"]

  timeouts {
    delete = "${var.tf_timeouts["delete"]}"
  }
}

resource "yandex_vpc_subnet" "b" {
  name           = "gc-subnet-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.prod-net.id
  v4_cidr_blocks = ["10.0.2.0/24"]

  timeouts {
    delete = "${var.tf_timeouts["delete"]}"
  }
}

resource "yandex_vpc_subnet" "c" {
  name           = "gc-subnet-c"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.prod-net.id
  v4_cidr_blocks = ["10.0.3.0/24"]

  timeouts {
    delete = "${var.tf_timeouts["delete"]}"
  }
}

# resource "yandex_vpc_subnet" "d" {
#   name           = "gc-subnet-d"
#   zone           = "ru-central1-d"
#   network_id     = yandex_vpc_network.prod-net.id
#   v4_cidr_blocks = ["10.0.4.0/24"]

#   timeouts {
#     delete = "${var.tf_timeouts["delete"]}"
#   }
# }
