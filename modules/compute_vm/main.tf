
resource "google_compute_instance" "vm_instance" {
  name         = "bm-cloud-worker-node1"
  machine_type = "e2-micro"
  tags         = var.def_tag
  boot_disk {
    initialize_params {
      image  = "debian-cloud/debian-11"
      labels = var.anthos_compute_instance_label
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = data.google_compute_network.test_vpc_network.name
    access_config {
    }
  }
}


resource "google_compute_instance" "bm_worker_nodes" {
  for_each = var.node_config

  name         = "bm-worker-${each.key}"
  machine_type = each.value.machine_type
  zone         = each.value.zone

  hostname = "${each.key}-bm-worker.com"

  boot_disk {
    initialize_params {
      size   = each.value.disk_size_gb
      image  = "ubuntu-os-cloud/ubuntu-2204-lts"
      labels = var.anthos_compute_instance_label
    }
  }
  network_interface {
    # A default network is created for all GCP projects
    network = data.google_compute_network.test_vpc_network.name
    access_config {
    }
  }
  # Additional instance configurations...
}


resource "google_compute_instance" "bm_workstation" {
  name         = "bm-cloud-wkst"
  machine_type = var.bm_instance_config.machine_type
  tags         = var.def_tag
  hostname     = "bm-wkst.com"
  zone         = var.bm_instance_config.zone
  boot_disk {
    initialize_params {
      image  = "ubuntu-os-cloud/ubuntu-2204-lts"
      size   = var.bm_instance_config.disk_size_gb
      labels = var.anthos_compute_instance_label
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = data.google_compute_network.test_vpc_network.name
    access_config {
    }
  }
}

resource "google_compute_instance" "bm_control_plane" {
  name         = "bm-cloud-cp"
  machine_type = var.bm_instance_config.machine_type
  tags         = var.def_tag
  hostname     = "bm-cp.com"
  zone         = var.bm_instance_config.zone
  boot_disk {
    initialize_params {
      image  = "ubuntu-os-cloud/ubuntu-2204-lts"
      size   = var.bm_instance_config.disk_size_gb
      labels = var.anthos_compute_instance_label
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = data.google_compute_network.test_vpc_network.name
    access_config {
    }
  }
}
