provider "yandex" {
  token     = var.token
  folder_id = var.folder_id
  cloud_id = var.cloud_id
  zone      = "ru-central1-a"
}
###############

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">= 0.98.0"
    }
  }
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "gc-tfstate-backet"
    region     = "ru-central1"

    skip_region_validation      = true
    skip_credentials_validation = true
    key               = "infra/terraform.tfstate"
    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1go3en2ogsej0t5u5qc/etnmrqmkpkjgvh6adka0"
    dynamodb_table = "gc-tfstate-db"
  }
}

// Create SA for same services
resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name      = var.sa_name
}

// Grant permissions SA
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_kms_symmetric_key" "key-services" {
  name              = "symetric-key-services"
  description       = "Symetric key Yandex KMS for services"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // equal to 1 year
}

#resource "yandex_lb_target_group" "target_group" {
#  name      = "my-target-group"
#  region_id = "ru-central1"
#
#  target {
#    subnet_id = "${yandex_vpc_subnet.a.id}"
#    address   = "${yandex_compute_instance.my-instance-1.network_interface.0.ip_address}"
#  }
#
#  target {
#    subnet_id = "${yandex_vpc_subnet.b.id}"
#    address   = "${yandex_compute_instance.my-instance-2.network_interface.0.ip_address}"
#  }
#}

#
