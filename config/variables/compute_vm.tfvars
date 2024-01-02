node_config = {
  instance1 = {
    machine_type = "e2-standard-8"
    zone         = "us-east1-a"
    disk_size_gb = 10
  }
  instance2 = {
    machine_type = "e2-standard-8"
    zone         = "us-east1-b"
    disk_size_gb = 10
  }
}

bm_instance_config = {

  machine_type = "e2-standard-8"
  zone         = "us-east1-a"
  disk_size_gb = 50

}



anthos_compute_instance_label = {

  name = "anthos"
  type = "bare_metal"

}
