terraform {
  required_version=">=0.15"
}

resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
}