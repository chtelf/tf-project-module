resource "google_compute_network" "main_infra" {
  name = "${var.name}-vpc"
  auto_create_subnetworks = var.auto_create_subnetworks
}

locals {
  subnets = {
      for x in var.subnets :
      "${x.subnet_name}" => x
  }
}

resource "google_compute_subnetwork" "main_infra" {
  for_each                 = local.subnets
  name                     = each.value.subnet_name
  ip_cidr_range            = each.value.subnet_ip
  region                   = each.value.subnet_region
  private_ip_google_access = lookup(each.value,"subnet_subnet_private_access","false")
  description              = lookup(each.value,"description",null)
  network                  = google_compute_network.main_infra.self_link
  secondary_ip_range = [
    for i in range(
        length(
            contains(
            keys(var.secondary_ranges), each.value.subnet_name) == true
            ? var.secondary_ranges[each.value.subnet_name]
            : []
            )) :
            var.secondary_ranges[each.value.subnet_name][i]
      ]
}