###############################################################################
# Variables - VPC
###############################################################################
variable "region" {
  description = "Default Region."
}

variable "environment" {
  description = "The name of the environment, e.g. Production, Development, etc."
}

variable "vpc_name" {
  description = "VPC Name"
}

variable "vpc_cidr" {
  description = "VPC CIDR block."
}

variable "map_public_ip_on_launch" {
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false."
  type        = bool
  default     = false
}

variable "public_cidr_a" {
  description = "Public CIDR block A."
}

variable "public_cidr_b" {
  description = "Public CIDR block B."
}

variable "public_cidr_c" {
  description = "Public CIDR block C."
}

variable "private_cidr_a" {
  description = "Private CIDR block A."
}

variable "private_cidr_b" {
  description = "Private CIDR block B."
}

variable "private_cidr_c" {
  description = "Private CIDR block C."
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Name of resource"
  type        = string
  default     = null
}
