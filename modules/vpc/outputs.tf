output "compute_zones" {
  value = data.google_compute_zones.available_comp_zones.names
}

output "o_vpc_name" {
  value = google_compute_network.dg_vpc.name
}

output "o_vpc_id" {
  value = google_compute_network.dg_vpc.id
}
output "o_vpc_self_link" {
  value = google_compute_network.dg_vpc.self_link
}

output "o_vpc_gateway_ipv4" {
  value = google_compute_network.dg_vpc.gateway_ipv4
}
