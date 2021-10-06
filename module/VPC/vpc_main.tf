
# VPC main

resource "aws_vpc" "main" {
  
  cidr_block       = var.aws_vpc_cidr
  instance_tenancy = "default"

}



# VPC internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

}



#private nat gateway
resource "aws_nat_gateway" "nat_gw_private" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.main_private_sub.id
}


###############################################################################
################################Public Subnet##################################


# Public Subnet associated with VPC main
resource "aws_subnet" "main_public_sub" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
  availability_zone = var.aws_vpc_sub_az
}

# routing table
resource "aws_route_table" "public_table" {
  vpc_id = aws_vpc.main.id

  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }
}

# associating the public route table with the public subnet
resource "aws_route_table_association" "eu-west-1a-public" {
    subnet_id = aws_subnet.main_public_sub.id
    route_table_id = aws_route_table.public_table.id
}



###############################################################################
##############################Private Subnet####################################


# Private Subnet associated with VPC main
resource "aws_subnet" "main_private_sub" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr
  availability_zone = var.aws_vpc_sub_az
}

resource "aws_route_table" "private_table" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gw_private.id
    }

}

resource "aws_route_table_association" "eu-west-1a-private" {
    subnet_id = aws_subnet.main_private_sub.id
    route_table_id = aws_route_table.private_table.id
}



#########################VPC flowlogs#####################################

resource "aws_cloudwatch_log_group" "vpc_log_group" {
  name = "log_vpc"
}


resource "aws_flow_log" "vpc_flow_log" {
  
  iam_role_arn    = aws_iam_role.vpc_flow_logs.arn
  log_destination = aws_cloudwatch_log_group.vpc_log_group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main.id
  
}

#########################Network ACL#####################################

resource "aws_network_acl" "main" {
  vpc_id = aws_vpc.main.id

  egress{
      protocol   = var.network_acl_egress.protocol
      rule_no    = var.network_acl_egress.rule_no
      action     = var.network_acl_egress.action
      cidr_block = var.public_subnet_cidr
      from_port  = var.network_acl_egress.from_port
      to_port    = var.network_acl_egress.to_port
  }
  

  ingress{
      protocol   = var.network_acl_ingress.protocol
      rule_no    = var.network_acl_ingress.rule_no
      action     = var.network_acl_ingress.action
      cidr_block = var.public_subnet_cidr
      from_port  = var.network_acl_ingress.from_port
      to_port    = var.network_acl_ingress.to_port
  }
  

}


#########################Network Security Group#####################################



resource "aws_security_group" "Main_vpc" {
  name        = "Main_vpc"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress{
      description      = var.security_group_ingress.description
      from_port        = var.security_group_ingress.from_port
      to_port          = var.security_group_ingress.to_port
      protocol         = var.security_group_ingress.protocol
      cidr_blocks      = [aws_vpc.main.cidr_block,]
      
  }
  

  egress{
      from_port        = var.security_group_egress.from_port
      to_port          = var.security_group_egress.to_port
      protocol         = var.security_group_egress.protocol
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
  }
 
}
