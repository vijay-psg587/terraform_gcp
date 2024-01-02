variable "m_vpc" {
  type        = map(string)
  description = "strings of all things to be used within vpc"
}

variable "m_def_tags" {
  type        = list(string)
  description = "Default tags from common tfvars"
}


variable "m_vpc_web_target_tags" {
  type        = list(string)
  description = "Default target tags from common tfvars"
}


variable "m_log_config" {
  type = list(string)
  default = [
    "aggregation_interval=INTERVAL_10_MIN",
    "flow_sampling=0.5",
    "metadata=INCLUDE_ALL_METADATA",

  ]
}
