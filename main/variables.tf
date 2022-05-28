###############################################################################
# Variables - Environment
###############################################################################
/*
variable "aws_account_id" {
  description = "(Required) AWS Account ID."
  type        = string
}
*/
variable "region" {
  description = "(Required) Region where resources will be created."
  type        = string
  default     = "ap-southeast-2"
}

variable "environment" {
  description = "(Optional) The name of the environment, e.g. Production, Development, etc."
  type        = string
  default     = "Development"
}

###############################################################################
# Variables - VPC
###############################################################################
variable "vpc_name" {
  description = "(Required) VPC Name."
  type        = string
}

variable "vpc_cidr" {
  description = "(Required) VPC CIDR block."
  type        = string
}

variable "map_public_ip_on_launch" {
  description = "(Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false."
  type        = bool
  default     = false
}

variable "public_cidr_a" {
  description = "(Required) Public CIDR block A."
  type        = string
}

variable "public_cidr_b" {
  description = "(Required) Public CIDR block B."
  type        = string
}

variable "public_cidr_c" {
  description = "(Required) Public CIDR block C."
  type        = string
}

variable "private_cidr_a" {
  description = "(Required) Private CIDR block A."
  type        = string
}

variable "private_cidr_b" {
  description = "(Required) Private CIDR block B."
  type        = string
}

variable "private_cidr_c" {
  description = "(Required) Private CIDR block C."
  type        = string
}

variable "my_ip" {
  default = "117.20.69.72/32"
}
