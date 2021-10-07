output "nlb_name" {

    value = aws_lb.network_lb.name
  
}

output "nlb_arn" {
    value = aws_lb.network_lb.arn
  
}

output "nlb_target_group_name" {
  value = aws_lb_target_group.lb_target_group.name
}

output "nlb_listner" {
  value = aws_lb_listener.front_end_forward.arn
  
}

output "vpc_id" {
  value = aws_vpc.lb_vpc.id
}

output "instance_arn" {
  value = aws_instance.test.arn
}