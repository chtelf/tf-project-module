variable "name" {
  default = "kube"
}

variable "project" {
  default = "kubernetes-275012"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-a"
}

variable "machine_type" {
  default = "f1-micro"
}

variable "ports" {
  type = list(string)
  default = ["80", "8080", "22"]
}

variable "auto_create_subnetworks" {
  type = bool
  default = false
}

variable "tags" {
  type = list(string)
  default = []
}

variable "number_node" {
  type = number
  default = 1
}

variable "image" {
  default = "debian-cloud/debian-10"
}

variable "ip_cidr_range" {
  default = "192.168.10.0/24"
}

variable "subnets" {
  type        = list(map(string))
  description = "The list of subnets being created"
}

variable "secondary_ranges" {
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  description = "Secondary ranges that will be used in some of the subnets"
  default     = {}
}