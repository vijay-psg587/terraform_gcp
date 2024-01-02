vpc_str = {
  vpc_name                  = "dg-vpc"
  subnet1_public_cidr_range = "10.0.0.0/16"
  subnet2_public_cidr_range = "10.0.1.0/16"

  subnet1_private_cidr_range = "192.1.0.0/16"
  subnet2_private_cidr_range = "192.2.0.0/16"
  subnet1_pp_region          = "us-east1"
  subnet2_pp_region          = "us-east2"
}

vpc_web_target_tags = ["web"]
