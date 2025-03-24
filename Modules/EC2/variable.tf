
variable "ebs_size" {
  description = "Size of the EBS volume in GB"
  type        = number

}
# variable "subnet_id" {
#   type = string
# }

variable "vpc_id" {
  type = string
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be launched"
  type        = string
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
}

variable "instance_name" {
  description = "Base name for instances"
  type        = string
}
