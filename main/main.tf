###############################################################################
# Terraform main config
###############################################################################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.75.1"
    }
    /*backend "s3" {
    bucket  = "XXXXXXXXXXXXXX-build-state-bucket-development" ### UPDATE XXXX WITH YOUR ACCOUNT NUMBER
    key     = "terraform.environment.tfstate"                 ### OPTIONALLY UPDATE KEY, IF YOU LIKE
    region  = "XXXXXXXXXXXXXX"                                ### UPDATE XXXX WITH YOUR REGION
    encrypt = "true"
    }*/
  }
}

###############################################################################
# Providers
###############################################################################
provider "aws" {
  region = "ap-southeast-2"
}

###############################################################################
# Data Sources
###############################################################################
locals {
  tags = {
    Environment = var.environment
    Terraform   = "True"
  }
}

###############################################################################
# Modules (VPC)
###############################################################################
module "vpc" {
  source = "../modules/vpc"

  region                  = var.region
  environment             = var.environment
  vpc_name                = var.vpc_name
  vpc_cidr                = var.vpc_cidr
  map_public_ip_on_launch = var.map_public_ip_on_launch
  public_cidr_a           = var.public_cidr_a
  public_cidr_b           = var.public_cidr_b
  public_cidr_c           = var.public_cidr_c
  private_cidr_a          = var.private_cidr_a
  private_cidr_b          = var.private_cidr_b
  private_cidr_c          = var.private_cidr_c
  tags                    = local.tags
}
###############################################################################
# Network ACL
###############################################################################
resource "aws_network_acl" "TestACL" {
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.all_subnets
  tags = {
    Name = "TestACL"
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = var.my_ip
    from_port  = 22
    to_port    = 22
  }
  egress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  #  ingress {
  #    protocol   = "icmp"
  #    rule_no    = 300
  #    action     = "allow"
  #    cidr_block = "0.0.0.0/0"
  #    from_port  = -1
  #    to_port    = -1
  #  }
  #  egress {
  #    protocol   = "icmp"
  #    rule_no    = 300
  #    action     = "allow"
  #    cidr_block = "0.0.0.0/0"
  #    from_port  = -1
  #    to_port    = -1
  #    icmp_type  = -1
  #    icmp_code  = -1
  #  }

  ingress {
    protocol   = "tcp"
    rule_no    = 500
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
    icmp_type  = -1
    icmp_code  = -1
  }
  egress {
    protocol   = "tcp"
    rule_no    = 500
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
    icmp_type  = -1
    icmp_code  = -1
  }

  #  ingress {
  #    protocol   = -1
  #    rule_no    = 600
  #    action     = "allow"
  #    cidr_block = "0.0.0.0/0"
  #    from_port  = 0
  #    to_port    = 0
  #  }
  #  egress {
  #    protocol   = -1
  #    rule_no    = 600
  #    action     = "allow"
  #    cidr_block = "0.0.0.0/0"
  #    from_port  = 0
  #    to_port    = 0
  #  }

}

resource "aws_network_acl_rule" "allow_ingress_icmp" {
  network_acl_id = aws_network_acl.TestACL.id
  rule_number    = 300
  egress         = false
  protocol       = "icmp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = -1
  to_port        = -1
  icmp_type      = -1
  icmp_code      = -1
}

resource "aws_network_acl_rule" "allow_egress_icmp" {
  network_acl_id = aws_network_acl.TestACL.id
  rule_number    = 300
  egress         = true
  protocol       = "icmp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = -1
  to_port        = -1
  icmp_type      = -1
  icmp_code      = -1
}
