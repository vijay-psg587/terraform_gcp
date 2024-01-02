output "project_number" {
  value = data.google_project.current_project.number
}

output "project_id" {
  value = data.google_project.current_project.project_id
}

output "compute_zones" {
  value = data.google_compute_zones.available_comp_zones.names
}

output "test_vpc_ipv4" {
  value = data.google_compute_network.test_vpc_network.gateway_ipv4
}

output "test_vpc_self_link" {
  value = data.google_compute_network.test_vpc_network.self_link
}
