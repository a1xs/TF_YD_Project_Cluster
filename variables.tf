variable "token" {}

variable "cloud_id" {
  type        = string
  description = "(Required) Your Cloud ID"
  default     = null
}
#
variable "folder_id" {
  type        = string
  description = "(Required) Your Folder ID"
  default     = null
}

#variable "dynamodb_endpoint" {
#  type        = string
#  description = "(Required) DynamoDB endpoint."
#  validation {
#    condition     = var.dynamodb_endpoint != null
#    error_message = "Endpoint is not set."
#  }
#  default = null
#}

variable "sa_name" {
  type        = string
  description = "The service account name"
  default = "sa-gc-services"
}

variable "bucket_name1" {
  type        = string
  description = "(Required) The name of the bucket."
  default = "radiographs-img-gc"
}

variable "bucket_name2" {
  type        = string
  description = "(Required) The name of the bucket."
  default = "users-img-gc"
}

variable "pg_user" {
  type        = string
  description = "(Required) Username for the DB."
  validation {
    condition     = var.pg_user != null
    error_message = "Username is not set."
  }
  default = null
}

variable "pg_password" {
  type        = string
  description = "(Required) Password for the DB."
  validation {
    condition     = var.pg_password != null
    error_message = "Password is not set."
  }
  default = null
}

variable "pg_database" {
  type        = string
  description = "(Required) DB name."
  validation {
    condition     = var.pg_database != null
    error_message = "DB name is not set."
  }
  default = null
}

variable "pg_cluster_name" {
  type        = string
  description = "The name cluster of the DB."
  default = "cluster-database"
}

variable "force_destroy" {
  description = "(Optional) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are NOT recoverable."
  type        = bool
  default     = false
}

variable "acl" {
  description = <<EOF
    (Optional) The predefined ACL to apply. Defaults to `private`. Conflicts with `grant` object.
    To change ACL after creation, service account with `storage.admin` role should be used, though this role is not necessary to create a bucket with any ACL.
    For more information see https://cloud.yandex.com/en/docs/storage/concepts/acl#predefined-acls.
  EOF
  type        = string
  default     = null
}

variable "kube_cluster_name" {
  type        = string
  description = "Name kubernetes cluster"
  default     = "cluster-kubernetes"
}

variable "kube_node_name" {
  type        = string
  description = "Name kubernetes node"
  default     = "node-kubernetes"
}

variable "node_groups" {
  description = "Parameters of Kubernetes node groups."
  default = {}
}

variable "kube_version" {
  type        = string
  description = "Kubernetes version"
  default     = "1.27"
}

variable "kube_node_conf" {
  description = "config group"
  type        = list(map(string))
  default     = [
    {
      type        = "node",
      ram         = "4",
      cpu         = "2",
      platform_id = "standard-v3",
      size = "64"
    }
  ]
}

variable "kafka_cluster_name" {
  type        = string
  description = "The name cluster of the kafka."
  default = "cluster-kafka"
}

variable "kafka_cluster_user" {
  type        = string
  description = "(Required) Password for the kafka."
  validation {
    condition     = var.kafka_cluster_user != null
    error_message = "Password is not set."
  }
  default = null
}

variable "kafka_cluster_password" {
  type        = string
  description = "(Required) Password for the kafka."
  validation {
    condition     = var.kafka_cluster_password != null
    error_message = "Password is not set."
  }
  default = null
}

variable "kafka_cluster_topics_name" {
  type        = list(string)
  description = "List topics for the kafka"
  default     = ["gc.radio.appd",
                 "gc.radio.chng",
                 "gc.radio.denormalize.after",
                 "gc.radio.denormalize.before",
                 "gc.radio.init",
                 "gc.radio.normalize.after",
                 "gc.radio.normalize.before",
                 "gc.radio.procd"
                ]
}

variable "tf_timeouts" {
  type = map(string)
  default = {
    create = "2h"
    update = "2h"
    delete = "2h"
  }
}