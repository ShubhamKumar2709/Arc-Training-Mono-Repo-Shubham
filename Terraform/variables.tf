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
