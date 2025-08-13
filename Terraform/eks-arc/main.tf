provider "aws" {
  region = var.region
}

module "tags" {
  source      = "sourcefuse/arc-tags/aws"
  version     = "1.2.2"
  environment = var.environment
  project     = "arc"

  extra_tags = {
    Repo = "github.com/sourcefuse/terraform-aws-arc-eks"
  }
}

module "eks_cluster" {
  source       = "sourcefuse/arc-eks/aws"
  version      = "5.0.14"
  environment  = var.environment
  name         = var.name
  namespace    = var.namespace
  desired_size = var.desired_size
  tags         = var.tags #
  #availability_zones                       = var.availability_zones
  instance_types                           = var.instance_types
  kubernetes_namespace                     = var.kubernetes_namespace
  create_node_group                        = true
  max_size                                 = var.max_size
  min_size                                 = var.min_size
  subnet_ids                               = data.aws_subnets.private.ids
  region                                   = var.region
  vpc_id                                   = data.aws_vpc.vpc.id
  enabled                                  = true
  kubernetes_version                       = var.kubernetes_version
  apply_config_map_aws_auth                = true
  kube_data_auth_enabled                   = true
  kube_exec_auth_enabled                   = true
  csi_driver_enabled                       = var.csi_driver_enabled
  oidc_provider_enabled                    = var.oidc_provider_enabled                    #
  local_exec_interpreter                   = var.local_exec_interpreter                   #
  cluster_encryption_config_kms_key_id     = var.cluster_encryption_config_kms_key_id     #
  enabled_cluster_log_types                = var.enabled_cluster_log_types                #
  cluster_log_retention_period             = var.cluster_log_retention_period             #
  cluster_encryption_config_enabled        = var.cluster_encryption_config_enabled        #
  cluster_encryption_config_kms_key_policy = var.cluster_encryption_config_kms_key_policy #
  kubernetes_labels                        = var.kubernetes_labels                        #
  addons                                   = var.addons                                   #

  map_additional_iam_roles = var.map_additional_iam_roles
  allowed_security_groups  = concat(data.aws_security_groups.eks_sg.ids, data.aws_security_groups.db_sg.ids)
}
