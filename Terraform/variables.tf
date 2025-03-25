variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "az" {
  description = "List of availability zones"
  type        = list(string)
}

variable "publicsubnet" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "privatesubnet" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "create_internet_gateway" {
  description = "Whether to create an internet gateway"
  type        = bool
}

variable "create_nat_gateway" {
  description = "Whether to create NAT gateways"
  type        = bool
}

variable "nat_gateway_count" {
  description = "Number of NAT gateways to create"
  type        = number
}


### EC2


variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
}


variable "key_name" {
  type        = string
  description = "Key pair name for SSH access"
}

variable "instance_name" {
  type        = string
  description = "Name for the EC2 instance"
}

variable "ebs_size" {
  type        = number
  description = "Size of the EBS volume in GB"
}




variable "environment" {
  type        = string
  description = "Environment name"
}

variable "namespace" {
  type        = string
  description = "Namespace for resource naming"
}


## RDS Variables
variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_engine" {
  type        = string
  description = "Database engine type"
}

variable "db_engine_version" {
  type        = string
  description = "Database engine version"
}

variable "db_instance_class" {
  type        = string
  description = "Database instance type"
}

variable "db_username" {
  type        = string
  description = "Database username"
}

variable "db_password" {
  type        = string
  description = "Database password (if not managed automatically)"
  default     = null
  sensitive   = true
}

variable "manage_user_password" {
  type        = bool
  description = "If true, a random password will be generated if no password is provided."
}


variable "rds_security_group" {
  type = object({
    create      = bool
    description = string
    ingress_rules = list(object({
      description = string
      cidr_block  = string
      from_port   = number
      to_port     = number
      ip_protocol = string
    }))
    egress_rules = list(object({
      description = string
      cidr_block  = string
      from_port   = number
      to_port     = number
      ip_protocol = string
    }))
  })
  description = "Security group configuration for RDS"
}
