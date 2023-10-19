# resource "yandex_vpc_security_group" "secur_group" {
#   name        = "Project security group"
#   description = "Project security group"
#   network_id  = "${yandex_vpc_network.prod-net.id}"

#   labels = {
#     my-label = "my-label-value"
#   }

#   ingress {
#     protocol       = "TCP"
#     description    = "rule1 description"
#     v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#     port           = 8080
#   }

#   egress {
#     protocol       = "ANY"
#     description    = "rule2 description"
#     v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#     from_port      = 8090
#     to_port        = 8099
#   }
# }

#resource "yandex_vpc_security_group" "k8s-main-sg" {
#  name        = "k8s-main-sg"
#  description = "Group rules support basic cluster functionality. Apply it to the cluster and node groups."
#  network_id  = "${yandex_vpc_network.prod-net.id}"
#  ingress {
#    protocol          = "TCP"
#    description       = "The rule allows availability checks from the load balancer address range. It is required for the operation of a fault-tolerant cluster and load balancer services."
#    predefined_target = "loadbalancer_healthchecks"
#    from_port         = 0
#    to_port           = 65535
#  }
#  ingress {
#    protocol          = "ANY"
#    description       = "The rule allows master to node and node to node communication inside a security group."
#    predefined_target = "self_security_group"
#    from_port         = 0
#    to_port           = 65535
#  }
#  ingress {
#    protocol       = "ANY"
#    description    = "Rule allows pod-pod and service-service communication. Specify the subnets of your cluster and services."
#    v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#    from_port      = 0
#    to_port        = 65535
#  }
#  ingress {
#    protocol       = "ICMP"
#    description    = "Rule allows debugging ICMP packets from internal subnets."
#    v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#  }
#  egress {
#    protocol       = "ANY"
#    description    = "Rule allows all outgoing traffic. Nodes can connect to Yandex Container Registry, Object Storage, Docker Hub, and so on."
#    v4_cidr_blocks = ["0.0.0.0/0"]
#    from_port      = 0
#    to_port        = 65535
#  }
#}
#
#resource "yandex_vpc_security_group" "k8s-public-services" {
#  name        = "k8s-public-services"
#  description = "Group rules allow connections to services from the internet. Apply the rules only for node groups."
#  network_id  = "${yandex_vpc_network.prod-net.id}"
#
#  ingress {
#    protocol       = "TCP"
#    description    = "Rule allows incoming traffic from the internet to the NodePort port range. Add ports or change existing ones to the required ports."
#    v4_cidr_blocks = ["0.0.0.0/0"]
#    from_port      = 30000
#    to_port        = 32767
#  }
#}
#
#resource "yandex_vpc_security_group" "k8s-master-whitelist" {
#  name        = "k8s-master-whitelist"
#  description = "Group rules allow access to the Kubernetes API from the internet. Apply the rules to the cluster only."
#  network_id  = "${yandex_vpc_network.prod-net.id}"
#
#  ingress {
#    protocol       = "TCP"
#    description    = "Rule allows connections to the Kubernetes API via port 6443 from a specified network."
#    v4_cidr_blocks = ["0.0.0.0/0"]
#    port           = 6443
#  }
#
#  ingress {
#    protocol       = "TCP"
#    description    = "Rule allows connections to the Kubernetes API via port 443 from a specified network."
#    v4_cidr_blocks = ["0.0.0.0/0"]
#    port           = 443
#  }
#}
#
#resource "yandex_vpc_security_group" "DataBase-access-rules" {
#  name        = "k8s-master-whitelist"
#  description = "Group rules allow access to the Kubernetes API from the internet. Apply the rules to the cluster only."
#  network_id  = "${yandex_vpc_network.prod-net.id}"
#
#  ingress {
#    protocol       = "TCP"
#    description    = "Rule allows connections to the Kubernetes API via port 6443 from a specified network."
#    v4_cidr_blocks = ["0.0.0.0/0"]
#    port           = 6432
#  }
#}
