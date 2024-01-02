output "project_number" {
  value = data.google_project.current_project.number
}

output "project_id" {
  value = data.google_project.current_project.project_id
}

output "compute_zones" {
  value = data.google_compute_zones.available_comp_zones.names
}
