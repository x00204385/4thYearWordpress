variable "subnets" {
  description = "Subnet ids into used for the EKS cluster"
  type        = list(string)
  default     = null
}

variable "node_subnets" {
  description = "Subnet ids used by the EKS nodes"
  type        = list(string)
  default     = null
}

variable "instance-ami" {
  description = "The AMI used to create the instances"
  type = string
  default = "ami-0cc4e06e6e710cd94"
}

variable "key-pair" {
  default = "tud-aws"
}

variable "security_group_ids" {
  default = []
}

variable "vpc_id" {
  description = "ID of the VPC where to EKS cluster will be created"
  type        = string
  default     = null
}

variable "region" {
  description = "The region in which the EKS cluster is created"
  type = string
  default = null
}

variable "suffix" {
  description = "Suffix to use to differentiate resources in different regions"
  type = string
  default = null
}
