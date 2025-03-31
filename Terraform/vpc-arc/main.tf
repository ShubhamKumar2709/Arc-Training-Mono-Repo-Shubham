provider "aws" {
  region = var.region

  default_tags {
    tags = module.tags.tags
  }
}



module "tags" {
  source  = "sourcefuse/arc-tags/aws"
  version = "1.2.3"

  environment = var.environment
  project     = "terraform-aws-ref-arch-network"

  extra_tags = {
    Example = "True"
  }
}



module "network" {
  source  = "sourcefuse/arc-network/aws"
  version = "3.0.4"

  namespace   = var.namespace
  environment = var.environment


  name                    = "${var.namespace}-${var.environment}"
  create_internet_gateway = true
  subnet_map              = local.subnet_map
  cidr_block              = "192.0.0.0/16"


  vpc_flow_log_config = {
    enable            = false
    retention_in_days = 0
    s3_bucket_arn     = null
  }

  vpc_endpoint_data = [
    {
      service            = "s3"
      route_table_filter = "private"
    },
    {
      service            = "dynamodb"
      route_table_filter = "private"
    }
  ]

  tags = module.tags.tags
}
