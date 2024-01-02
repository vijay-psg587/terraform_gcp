variable "def_tag" {
  description = "Value to be used as tags from parent"
}

variable "def_network" {
  description = "network name from parent"
}

variable "anthos_compute_instance_label" {
  type        = map(string)
  description = "Label for anothos"
}



variable "node_config" {
  type = map(object({
    machine_type = string
    zone         = string
    disk_size_gb = number
  }))
  description = "This is the node configuration"
}

variable "bm_instance_config" {
  type = object({
    machine_type = string
    zone         = string
    disk_size_gb = number
  })
  description = "THis is the  configuration for workstation and control plane"
}

