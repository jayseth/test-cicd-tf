output "dax" {

    value = aws_dax_cluster.new_cluster.arn
  
}
output "cluster_address_dax" {

    value = aws_dax_cluster.new_cluster.cluster_address
  
}