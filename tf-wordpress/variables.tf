#   default = "ami-0333305f9719618c7"
#   default = "ami-0cc4e06e6e710cd94" Ubuntu 20.04 focal


variable "region" {
  default = "eu-west-1"
}

variable "profile" {
  default = "tud-admin"
}

variable "instance-ami" {
  default = "ami-0cc4e06e6e710cd94"
}

variable "db_username" {
  default = "wp_user"
}

variable "db_password" {
  default = "Computing1"
}