resource "google_compute_network" "dg_vpc" {
  name                                      = var.m_vpc.vpc_name
  project                                   = data.google_project.current_project.project_id
  auto_create_subnetworks                   = false
  mtu                                       = 1500
  network_firewall_policy_enforcement_order = "BEFORE_CLASSIC_FIREWALL"
}

resource "google_compute_subnetwork" "dg_public_subnet1" {
  name          = "${var.m_vpc.vpc_name}-public"
  ip_cidr_range = var.m_vpc.subnet1_public_cidr_range
  network       = google_compute_network.dg_vpc.id
  role          = "ACTIVE"
  region        = var.m_vpc.subnet1_pp_region
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

}

resource "google_compute_subnetwork" "dg_private_subnet1" {
  name                     = "${var.m_vpc.vpc_name}-private"
  ip_cidr_range            = var.m_vpc.subnet1_private_cidr_range
  network                  = google_compute_network.dg_vpc.id
  role                     = "ACTIVE"
  region                   = var.m_vpc.subnet1_pp_region
  private_ip_google_access = "true"

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}


resource "google_compute_subnetwork" "dg_private_nat_subnet" {
  name                     = "${var.m_vpc.vpc_name}-private-nat"
  ip_cidr_range            = var.m_vpc.subnet2_private_cidr_range
  network                  = google_compute_network.dg_vpc.id
  role                     = "ACTIVE"
  purpose                  = "PRIVAT_NAT"
  region                   = var.m_vpc.subnet1_pp_region
  private_ip_google_access = "true"

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

# Custom firewall  that allows to ssh
resource "google_compute_firewall" "tcp_vpc_rule" {
  project     = data.google_project.current_project.project_id
  name        = "dg-vpc-firewall-custom-1"
  network     = google_compute_network.dg_vpc.id
  description = "Creates firewall rule targeting tagged instances for ssh and web"

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "443", "1000-2000", "22"]
  }
  source_tags = ["test-src-tag"]

  target_tags = var.m_vpc_web_target_tags
}

# Creating a custom Cloud NAT gateway since we wouldnt be allowed to create VM instances with external IP address
resource "google_compute_router" "nat_router" {
  name    = "nat-router"
  network = google_compute_network.dg_vpc.self_link
}

resource "google_compute_router_nat" "nat_config" {
  name                           = "nat-config"
  router                         = google_compute_router.nat_router.name
  source_subnet_ip_ranges_to_nat = [google_compute_subnetwork.my_subnet.ip_cidr_range]

  nat_ip_allocate_option = "AUTO_ONLY"
}

resource "google_compute_router_nat_logging" "nat_logging" {
  router_nat_log = google_compute_router_nat.nat_config.name
  filter         = "ERRORS_ONLY"
  enable         = true
}
