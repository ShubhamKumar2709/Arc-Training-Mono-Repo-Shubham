module "vpc" {
  source = ".././Modules/vpc"

  cidr                    = var.cidr
  az                      = var.az
  publicsubnet            = var.publicsubnet
  privatesubnet           = var.privatesubnet
  create_internet_gateway = var.create_internet_gateway
  create_nat_gateway      = var.create_nat_gateway
  nat_gateway_count       = var.nat_gateway_count
}
