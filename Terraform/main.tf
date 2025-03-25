terraform {
  required_version = ">= 1.3.0"
}



module "vpc" {
  source                  = ".././Modules/vpc"
  cidr                    = var.cidr
  az                      = var.az
  publicsubnet            = var.publicsubnet
  privatesubnet           = var.privatesubnet
  create_internet_gateway = var.create_internet_gateway
  create_nat_gateway      = var.create_nat_gateway
  nat_gateway_count       = var.nat_gateway_count
}





module "ec2_instance" {
  source           = ".././Modules/EC2"
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  key_name         = var.key_name
  instance_name    = var.instance_name
  ebs_size         = var.ebs_size
  subnet_id        = module.vpc.public_subnet_ids[0]
  vpc_id           = module.vpc.vpc_id
  root_volume_size = var.root_volume_size
  instance_count   = var.instance_count

}



module "rds" {
  source = ".././Modules/RDS"
  #region      = var.region
  environment = var.environment
  namespace   = var.namespace

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids

  name                 = var.db_name
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  username             = var.db_username
  password             = var.db_password
  manage_user_password = var.manage_user_password

  security_group_data = var.rds_security_group
}
