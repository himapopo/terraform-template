module "vpc" {
  source               = "../../modules/network"
  vpc_cidr_block       = "10.1.0.0/16"
  subnet_1a_cidr_block = "10.1.1.0/24"
  subnet_1c_cidr_block = "10.1.2.0/24"
  enable_dns_hostnames = true
  env                  = var.env
}