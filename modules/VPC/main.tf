terraform {
  required_version=">=0.14"
}

resource "aws_vpc" "default" {
  cidr_block = var.cidr
}

variable "cidr" {
  type = string
  description = "CIDR BLOCK"
}
  
