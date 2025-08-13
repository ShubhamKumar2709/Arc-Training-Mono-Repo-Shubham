################################################################################
## shared
################################################################################
variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "environment" {
  type        = string
  default     = "poc"
  description = "ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT'"
}

variable "namespace" {
  type        = string
  default     = "arc"
  description = "ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique"
}

# variable "username" {
#   type = string
# }

# variable "name" {
#   type        = string
#   description = "The name of the Aurora database"
# }

# variable "namespace" {
#   description = "Namespace for resource naming"
#   type        = string
# }

# variable "environment" {
#   description = "Deployment environment (e.g., dev, prod)"
#   type        = string
# }

# variable "db_username" {
#   description = "Username for the database"
#   type        = string
#   default     = "postgres"
# }

# variable "db_port" {
#   description = "Port for the database"
#   type        = number
#   default     = 5432
# }

# variable "engine_type" {
#   description = "Type of database engine"
#   type        = string
#   default     = "cluster"
# }

# variable "engine" {
#   description = "Database engine"
#   type        = string
#   default     = "aurora-postgresql"
# }

# variable "engine_version" {
#   description = "Database engine version"
#   type        = string
#   default     = "16.2"
# }

# variable "license_model" {
#   description = "License model for the database"
#   type        = string
#   default     = "postgresql-license"
# }

# variable "rds_cluster_instances" {
#   description = "List of RDS cluster instances"
#   type = list(object({
#     instance_class          = string
#     db_parameter_group_name = string
#     apply_immediately       = bool
#     promotion_tier          = number
#   }))
# }

# variable "db_subnet_group_data" {
#   description = "Database subnet group configuration"
#   type = object({
#     name        = string
#     create      = bool
#     description = string
#     subnet_ids  = list(string)
#   })
# }

# variable "performance_insights_enabled" {
#   description = "Enable performance insights"
#   type        = bool
#   default     = false
# }

# variable "kms_data" {
#   description = "KMS configuration for Performance Insights and storage"
#   type = object({
#     create                  = bool
#     description             = string
#     deletion_window_in_days = number
#     enable_key_rotation     = bool
#   })
#   default = null
# }
