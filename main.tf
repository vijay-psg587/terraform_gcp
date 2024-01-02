terraform {
  # here configurations can be provided for the version to be locked with. As a best practice it should be provided
}

provider "google" {
  credentials = file(var.sa_key_loc)
  project     = var.gcp_project_id
  region      = var.gcp_us_region
  zone        = var.gcp_us_zone

  # this will be applied to all resources that are being created
  default_labels = {
    environment = "Sandbox" # best to come from variable being passed dynamically
    project     = var.gcp_project_id
  }
}

module "vpc" {
  source                = "./modules/vpc"
  m_vpc                 = var.vpc_str
  m_def_tags            = var.default_tags
  m_vpc_web_target_tags = var.vpc_web_target_tags
}

# module "compute" {
#   source                        = "./modules/compute_vm"
#   def_tag                       = var.default_tags
#   def_network                   = var.gcp_network_name
#   node_config                   = var.node_config
#   bm_instance_config            = var.bm_instance_config
#   anthos_compute_instance_label = var.anthos_compute_instance_label
# }

# output "compute_module_output_cp_zones" {
#   # value = module.compute.test_vpc_self_link
#   # value = module.compute.test_vpc_ipv4
#   value = module.compute.compute_zones
# }

# output "compute_module_vpc_link" {
#   value = module.compute.test_vpc_self_link
# }

output "vpc_link" {
  value = module.vpc.o_vpc_self_link
}

output "vpc_name" {
  value = module.vpc.o_vpc_name
}

output "vpc_id" {
  value = module.vpc.o_vpc_id
}

output "gateway" {
  value = module.vpc.o_vpc_gateway_ipv4
}

# resource "google_compute_network" "vpc_network" {
#   name                    = "terraform-network"
#   auto_create_subnetworks = "true"

# }

# resource "google_compute_instance" "vm_instance" {
#   name         = "terraform-instance"
#   machine_type = "e2-micro"
#   tags         = var.default_tags
#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-11"
#     }
#   }

#   network_interface {
#     # A default network is created for all GCP projects
#     network = "default"
#     access_config {
#     }
#   }
# }
