data "google_project" "current_project" {}

data "google_compute_zones" "available_comp_zones" {}

data "google_compute_network" "test_vpc_network" {
  name = var.def_network
}
