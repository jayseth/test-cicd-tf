#Creation of Network Load Balancer

resource "aws_lb" "network_lb" {
  name                       = var.aws_network_lb_name
  internal                   = false
  load_balancer_type         = var.lb_type
  
  enable_deletion_protection = var.enable_deletion_protection

  subnet_mapping {
    subnet_id     = aws_subnet.lb_subnet.0.id
    allocation_id = aws_eip.eip1.0.id
  }

  subnet_mapping {
    subnet_id     = aws_subnet.lb_subnet.1.id
    allocation_id = aws_eip.eip1.1.id
  }

   depends_on = [
    aws_internet_gateway.gw
  ]

}


# Load Balancer Target Group(Types can be : instance, ip, lambda, default=instance)

resource "aws_lb_target_group" "lb_target_group" {
  name     = "network-lb-target-group"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.lb_vpc.id
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = aws_instance.test.id
  port             = 80
}


resource "aws_eip" "eip1" {
  vpc                       = true
  count                     = 2
  associate_with_private_ip = var.private_ip_EIPS[count.index]
  depends_on                = [aws_internet_gateway.gw]
   
}



###############################################################################
######################## Load Balancer Listener ###############################


#Load Balancer Listener

resource "aws_lb_listener" "front_end_forward" {
  load_balancer_arn = aws_lb.network_lb.arn
  port              = "443"
  protocol          = "TCP"
 
  

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}




###############################################################################
######################## VPC for the Load Balancer ############################
#note: can be replaced by the vpc module

resource "aws_vpc" "lb_vpc" {
    cidr_block       = var.aws_vpc_cidr
    instance_tenancy = "default"
  
}
/*
Subnets for the load balancer(set count for number of subnets for the load balancers)
Note: for load balancer minimum of 2 subnets are required and in different availibility zones.
*/
resource "aws_subnet" "lb_subnet" {
    count               = var.lb_subnet_count
    vpc_id              = aws_vpc.lb_vpc.id
    cidr_block          = var.public_subnet_cidr[count.index]
    availability_zone   = var.aws_vpc_sub_az[count.index]
    
}

/*
Internet Gateway for the load balancer is required. 
Also put depends_on clause in Load balancer resource.

*/
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.lb_vpc.id

}



