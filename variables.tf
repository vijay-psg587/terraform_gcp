variable "gcp_project_id" {
  type        = string
  description = "The project id of the gcp service provider"
  default     = "galvanic-deck-394114"
}

variable "gcp_us_region" {
  type        = string
  description = "Region associated with the project"
  default     = "us-east1"
  sensitive   = false
  validation {
    condition     = can(regex("^(us){1}[-][-a-zA-Z0-9]*$", var.gcp_us_region))
    error_message = "The region should always be a us-region. Please correct it"
  }
}

variable "sa_key_loc" {
  type    = string
  default = "./config/key_loc/sa_key.json"

}
variable "gcp_us_zone" {
  type        = string
  description = "Region associated with the project"
  default     = "us-east1-a"
  validation {
    condition     = can(regex("^(us){1}[-][-a-zA-Z0-9]*$", var.gcp_us_zone))
    error_message = "The region should always be a us-zone. Please correct it"
  }
}

variable "default_tags" {
  type        = list(string)
  description = "Default tags to be used for a resource"
  default = [
    "Environment=Sandbox",
    "Owner=Vijay",
    "Project=Test"
  ]
}



variable "gcp_network_name" {
  type        = string
  description = "Network name to be provided"
  validation {
    condition     = length(var.gcp_network_name) > 0 #Error will be triggered only during the condition is FALSE. So make sure to create conditions like that
    error_message = "There has to be a network name provided at all times, These are already created"
  }
}



variable "anthos_compute_instance_label" {
  type        = map(string)
  description = "Label for anothos"
}

variable "east_cp_zone_1" {
  type = string
}

variable "east_cp_zone_2" {
  type = string
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
  description = "THis is the workstation configuration and control plane config"
}


variable "vpc_str" {
  type        = map(string)
  description = "strings of all things to be used within vpc"

}

variable "vpc_web_target_tags" {
  type        = list(string)
  description = "Web targeted VM instances"
}
